//
//  ServerRepoSignInResponse.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import Vapor
import NoServerAuth

public final class ServerRepoSignInResponse: Content {
 
    public var user: User?
    
    public var credentials: ClientCredentials?
    
    public init(user: User? = nil, credentials: ClientCredentials? = nil) {
        self.user = user
        self.credentials = credentials
    }
}
