//
//  File.swift
//  
//
//  Created by Guerson Perez on 20/05/24.
//

import Vapor
import NoServerAuth

public final class UserSignInResponse: Content {
    
    var user: User?
    
    var credentials: ClientCredentials?
    
    init(user: User? = nil, credentials: ClientCredentials? = nil) {
        self.user = user
        self.credentials = credentials
    }
}
