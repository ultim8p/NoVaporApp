//
//  SignInController.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import Vapor
import MongoKitten

final class NoSignInController {
    
    let signInService: NoSignInService
    
    init(signInService: NoSignInService) {
        self.signInService = signInService
    }
    
    func registerAuthRoutes(_ routes: RoutesBuilder) {
        let v1 = routes.grouped("v1")
        let v1User = v1.grouped("user")
        let v1SignIn = v1User.grouped("signin")
        
        // MARK: POST
        
        v1SignIn.post("", use: postV1SignIn)
    }
    
    func postV1SignIn(_ req: Request) async throws -> UserSignInResponse {
        print("GOT SIGN IN")
        let authApp = try req.requireClientAppAuth
        print("GOT APP AUTH: \(authApp.identifier)")
        let request = try req.content.decode(NoSignInRequest.self)
        let db = req.mongoDB
        print("CREATED REQ")
        let result = try await signInService.signIn(
            db: db,
            app: authApp,
            request: request,
            headers: req.headers)
        print("GOT RESULT")
        return UserSignInResponse(user: result.user, credentials: result.credentials)
    }
}
