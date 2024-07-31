//
//  ServerRepo+Request.swift
//
//
//  Created by Guerson Perez on 12/22/23.
//

import Foundation
import Vapor
import MongoKitten
import NoServerAuth

public struct AppStoragetKey: StorageKey {
    
    public typealias Value = ClientApp
}

public extension Request {
    
    var authClientApp: ClientApp? {
        get {
            self.storage[AppStoragetKey.self]
        }
        set {
            self.storage[AppStoragetKey.self] = newValue
        }
    }
    
    var requireClientAppAuth: ClientApp {
        @discardableResult get throws {
            guard let authApp = authClientApp
            else { throw NoServerAuthError.missingAuthenticatedObject }
            return authApp
        }
    }
}

