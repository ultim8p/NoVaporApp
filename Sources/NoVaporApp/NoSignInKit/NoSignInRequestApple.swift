//
//  NoSignInRequestApple.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import Vapor

public final class NoSignInRequestApple: Content {
    
    public var dateCreated: Date?
    
    public var dateUpdated: Date?
    
    public var identityToken: Data?
    
    public var authorizationCode: Data?
    
    public var realUserStatus: String?
    
    public var user: String?
    
    public var email: String?
}
