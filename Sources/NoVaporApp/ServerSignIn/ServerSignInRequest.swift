//
//  ServerRepoSignInRequest.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Vapor

public final class ServerRepoSignInRequest: Content {
    
    public var user: User?
    
    public init(user: User? = nil) {
        self.user = user
    }
}
