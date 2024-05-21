//
//  File.swift
//  
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import Vapor
import MongoKitten

public final class NoSignInKit {
    
    let appId: String
    
    let client: Client
    
    let serverRepo: ServerRepo
    
    let service: NoSignInService
    
    let controller: NoSignInController
    
    init(appId: String, client: Client, serverRepo: ServerRepo) {
        self.appId = appId
        self.client = client
        self.serverRepo = serverRepo
        self.service = NoSignInService(appId: appId, client: client, serverRepo: serverRepo)
        self.controller = NoSignInController(signInService: service)
    }
    
    func registerAuthRoutes(_ routes: RoutesBuilder) {
        controller.registerAuthRoutes(routes)
    }
}
