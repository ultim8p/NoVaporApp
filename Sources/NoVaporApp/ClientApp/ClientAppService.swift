//
//  ClientAppService.swift
//  
//
//  Created by Guerson Perez on 12/22/23.
//

import Foundation
import Vapor
import MongoKitten
import NoServerAuth
import NoVaporError

public final class ClientAppService {
    
    public init() {
        
    }
    
    // MARK: - CREATE
    
    // Pass server serverId as serverId parameter.
    // ClientApp is the app which will be using this app ex: iOS app
    public func createApp(db: MongoDatabase, app: ClientApp, serverId: String) async throws -> (
        client: ClientCredentials,
        app: ClientApp
    ) {
        guard let appIdentifier = app.identifier,
              try await ClientApp.findOneOptional(in: db, query: ["identifier": appIdentifier]) == nil
        else { throw NoError.noServerApp(reason: "App with identifier exists", code: .duplicate) }
        
        
        let app = try ClientApp.build(identifier: app.identifier)
        guard let appId = app._id else { throw NoError.noServerApp(reason: "Missing app id", code: .missingValues) }
        
        let credentials = try String.noAuthCreateCredentials(
            entityId: appId,
            entity: AuthCredentialsType.app.rawValue,
            deviceName: "",
            serverAppIdentifier: appIdentifier,
            clientAppIdentifier: serverId
        )
        
        try await app.save(in: db)
        try await credentials.server.save(in: db)
        
        return (credentials.client, app)
    }
}
