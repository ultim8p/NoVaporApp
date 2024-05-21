//
//  NoSignInRequestApple.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import Vapor

final class NoSignInRequestApple: Content {
    
    var dateCreated: Date?
    
    var dateUpdated: Date?
    
    var identityToken: Data?
    
    var authorizationCode: Data?
    
    var realUserStatus: String?
    
    var user: String?
    
    var email: String?
}
