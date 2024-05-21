//
//  ServerRepo+AuthenticationHeaders.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Vapor
import Foundation
import NoServerAuth
import NoVaporError

public extension ServerRepo {
    
    // Create authentication headers for other ServerRepo
    func requestAuthHeaders(headers: HTTPHeaders, credentials: [ClientCredentials]? = nil) throws -> HTTPHeaders {
        guard let deviceName = headers.deviceName
        else { throw NoError.noVaporAppError(reason: "Missing object", code: .missingValues, fields: ["DeviceName"]) }
        
        var signingCredentials = [self.credentials]
        signingCredentials.append(contentsOf: credentials ?? [])
        
        guard let bearer = try key.apiAuthBearer(credentials: signingCredentials)
        else { throw NoError.noVaporAppError(reason: "Failed to create authentication bearer", code: .creation) }
        
        return HTTPHeaders([
            ("Authorization", "Bearer \(bearer)"),
            ("Content-Type", "application/json"),
            ("DeviceName", deviceName)
        ])
    }
}
