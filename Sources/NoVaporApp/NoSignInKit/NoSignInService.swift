//
//  File.swift
//  
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import Vapor
import MongoKitten
import NoMongo
import NoServerAuth
import NoVaporError

public final class NoSignInService {
    
    let appId: String
    
    let client: Client
    
    let serverRepo: ServerRepo
    
    enum Paths {
        static let v1SignIn = "/v1/nosignin/signin"
    }
    
    init( appId: String, client: Client, serverRepo: ServerRepo) {
        self.client = client
        self.appId = appId
        self.serverRepo = serverRepo
    }
    
    public func signIn(
        db: MongoDatabase, app: ClientApp, request: NoSignInRequest, headers: HTTPHeaders
    ) async throws -> (user: User, credentials: ClientCredentials) {
        let response = try await signIn(db: db, request: request, headers: headers)
        guard let user = response.user,
              let deviceName = headers.deviceName,
              let signInCredentials = response.credentials
        else { throw NoError.noServerApp(reason: "Signing response missing values", code: .missingValues) }
        
        try await user.save(in: db)
        try await signInCredentials.replaceOrSave(db: db)
        
        try await AppUser.ensureExists(db: db, app: app, user: user)
        
        let credentials = try await user.recreateCredentials(
            db: db, deviceName: deviceName, serverAppIdentifier: app.identifier, clientAppIdentifier: appId)
        
        return (user, credentials)
    }
}

private extension NoSignInService {
    
    func signIn(db: MongoDatabase, request: NoSignInRequest, headers: HTTPHeaders) async throws -> UserSignInResponse {
        return try await request.post(
            client: client,
            db: db,
            headers: headers,
            server: serverRepo,
            path: Paths.v1SignIn
        )
    }
}
