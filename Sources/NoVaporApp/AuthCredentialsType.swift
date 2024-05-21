//
//  File.swift
//  
//
//  Created by Guerson Perez on 12/22/23.
//

import Foundation

public enum AuthCredentialsType: String, Codable {
    
    case origin
    
    case app
    
    case user
    
    public var description: String {
        switch self {
        case .origin:
            return "origin"
        case .app:
            return "app"
        case .user:
            return "user"
        }
    }
    
    public var collectionName: String {
        switch self {
        case .origin:
            return ""
        case .app:
            return ClientApp.collectionName
        case .user:
            return User.collectionName
        }
    }
}
