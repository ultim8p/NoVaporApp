//
//  DeletionResponse.swift
//
//
//  Created by Guerson Perez on 31/07/24.
//

import Foundation
import Vapor
import MongoKitten

public final class DeletionResponse: Content {
    
    public var deletes: Int?
}

public extension DeleteReply {
    
    func deletionResponse() -> DeletionResponse {
        let response = DeletionResponse()
        response.deletes = deletes
        return response
    }
}
