//
//  File.swift
//  
//
//  Created by Guerson Perez on 20/05/24.
//

import Vapor
import NoMongo
import MongoKitten
import NoServerAuth
import NoVaporError

public final class ServerSignInController {
    
    let appId: String
    
    init(appId: String) {
        self.appId = appId
    }
    
    func registerAuthRoutes(_ routes: RoutesBuilder) {
        
        let v1 = routes.grouped("v1")
        let v1server = v1.grouped("server")
        
        
        //MARK: POST
        
        v1server.post("signin", use: postV1ServerSignIn)
    }
}

// MARK: - Server SignIn

public extension ServerSignInController {
    
    func postV1ServerSignIn(_ req: Request) async throws -> ServerRepoSignInResponse {
        let authApp = try req.requireClientAppAuth
        let request = try req.content.decode(ServerRepoSignInRequest.self)
        let db = req.mongoDB
        let headers = req.headers
        let result = try await signIn(
            db: db, app: authApp, request: request, headers: headers)
        
        return ServerRepoSignInResponse(user: result.user, credentials: result.credentials)
    }
}

private extension ServerSignInController {
    
    func signIn(
        db: MongoDatabase,
        app: ClientApp,
        request: ServerRepoSignInRequest,
        headers: HTTPHeaders
    ) async throws -> (user: User, credentials: ClientCredentials) {
        guard let requestUser = request.user else { throw NoError.noVaporAppError(reason: "Missing value SingIn user", code: .missingValues) }
        let deviceName = headers.deviceName
        
        let user = try await signedInUser(db: db, user: requestUser, app: app)
        let credentials = try await user.recreateCredentials(
            db: db, deviceName: deviceName, serverAppIdentifier: app.identifier, clientAppIdentifier: appId)
        
        return (user, credentials)
    }
    
    func signedInUser(db: MongoDatabase, user: User, app: ClientApp) async throws -> User {
        guard let existingUser = try await user.findOptional(in: db)
        else {
            return try await createUser(db: db, user: user, app: app)
        }
        return existingUser
    }
    
    func createUser(db: MongoDatabase, user: User, app: ClientApp) async throws -> User {
        let user = try User.build(user: user)
        try await user.save(in: db)
        
        try await AppUser.ensureExists(db: db, app: app, user: user)
        
        return user
    }
}
