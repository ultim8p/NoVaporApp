//
//  File.swift
//  
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import MongoKitten
import Vapor
import NoServerAuth
import NoVaporError
import NoMongo

public extension User {
    
    func ensureClientCredentials(
        client: Client,
        db: MongoDatabase,
        headers: HTTPHeaders,
        server: ServerRepo
    ) async throws -> ClientCredentials {
        guard let deviceName = headers.deviceName,
              let entityId = self._id
        else { throw NoError.noServerApp(reason: "Client Credentials", code: .creation) }
        
        guard let credentials = try await ClientCredentials.findOptional(
            db: db,
            entity: type(of: self).entityName,
            entityId: entityId,
            deviceName: deviceName,
            appIdentifier: server.identifier)
        else {
            let signinRequest = ServerRepoSignInRequest(user: self)
            let response: ServerRepoSignInResponse = try await signinRequest.post(
                client: client,
                db: db,
                headers: headers,
                server: server,
                path: "/v1/server/signin")
            guard let signedInCredentials = response.credentials
            else { throw NoError.noServerApp(reason: "Failed to create object", code: .creation, fields: [server.identifier]) }
            try await signedInCredentials.save(in: db)
            return signedInCredentials
        }
        return credentials
    }
}
