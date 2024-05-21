//
//  ServerRepo.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Vapor
import Foundation
import NoServerAuth
import NoVaporError

public final class ServerRepo {
    
    public var baseURL: String
    
    public var key: String
    
    public var credentials: ClientCredentials
    
    public var identifier: String
    
    public init(baseURL: String, key: String, credentials: ClientCredentials, identifier: String) {
        self.baseURL = baseURL
        self.key = key
        self.credentials = credentials
        self.identifier = identifier
    }
}
