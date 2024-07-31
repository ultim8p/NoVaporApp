//
//  EmptyResponse.swift
//
//
//  Created by Guerson Perez on 31/07/24.
//

import Foundation
import Vapor
import MongoKitten

public enum EmptyResponseResult: String, Codable {
    case ok
}

public final class EmptyResponse: Content {
    
    public var result: EmptyResponseResult?
    
    public static var ok: EmptyResponse {
        let response = EmptyResponse()
        response.result = .ok
        return response
    }
}
