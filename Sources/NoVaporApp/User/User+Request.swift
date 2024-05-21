//
//  File.swift
//  
//
//  Created by Guerson Perez on 12/22/23.
//

import Foundation
import Vapor
import MongoKitten
import NoServerAuth

public struct UserStorageKey: StorageKey {
    
    public typealias Value = User
}

public extension Request {
    
    var authUser: User? {
        get {
            self.storage[UserStorageKey.self]
        }
        set {
            self.storage[UserStorageKey.self] = newValue
        }
    }
    
    var requireUserAuth: User {
        @discardableResult get throws {
            guard let authUser = authUser
            else { throw NoServerAuthError.missingAuthenticatedObject }
            return authUser
        }
    }
}
