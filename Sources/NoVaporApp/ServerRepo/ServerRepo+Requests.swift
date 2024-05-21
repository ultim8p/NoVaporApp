//
//  ServerRepo.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import NoServerAuth
import NoMongo
import Vapor
import NoVaporError
import MongoKitten
import NoVaporAPI

// MARK: - Request URIs

public extension ServerRepo {
    
    func uri(path: CustomStringConvertible) -> URI {
        return URI(string: baseURL + path.description)
    }
}

// MARK: - Requests

public extension Content {
    
    func delete<T: Content>(
        client: Client,
        db: MongoDatabase,
        user: User? = nil,
        headers: HTTPHeaders,
        server: ServerRepo,
        path: CustomStringConvertible
    ) async throws -> T {
        var authCredentials: [ClientCredentials] = []
        
        if let user = user {
            let userCredentials = try await user.ensureClientCredentials(
                client: client,
                db: db,
                headers: headers,
                server: server
            )
            authCredentials.append(userCredentials)
        }
        
        let headers = try server.requestAuthHeaders(headers: headers, credentials: authCredentials)
        let uri = server.uri(path: path)
        return try await self.delete(
            client,
            uri: uri,
            headers: headers
        )
        .validate(type: NoError.self)
        .value(using: JSONDecoder.mongoDecoder)
    }
    
    func post<T: Content>(
        client: Client,
        db: MongoDatabase,
        user: User? = nil,
        headers: HTTPHeaders,
        server: ServerRepo,
        path: CustomStringConvertible
    ) async throws -> T {
        var authCredentials: [ClientCredentials] = []
        
        if let user = user {
            let userCredentials = try await user.ensureClientCredentials(
                client: client, db: db, headers: headers, server: server
            )
            authCredentials.append(userCredentials)
        }
        
        let headers = try server.requestAuthHeaders(headers: headers, credentials: authCredentials)
        let uri = server.uri(path: path)
        return try await self.post(
            client,
            uri: uri,
            headers: headers,
            contentEncoder: JSONEncoder.mongoEncoder
        )
        .validate(type: NoError.self)
        .value(using: JSONDecoder.mongoDecoder)
    }
    
    static func get(
        client: Client,
        db: MongoDatabase,
        user: User? = nil,
        headers: HTTPHeaders,
        server: ServerRepo,
        path: CustomStringConvertible
    ) async throws -> Self {
        var authCredentials: [ClientCredentials] = []
        
        if let user = user {
            let userCredentials = try await user.ensureClientCredentials(
                client: client, db: db, headers: headers, server: server
            )
            authCredentials.append(userCredentials)
        }
        
        let headers = try server.requestAuthHeaders(headers: headers, credentials: authCredentials)
        let uri = server.uri(path: path)
        return try await Self.get(client, uri: uri, headers: headers)
            .validate(type: NoError.self)
            .value(using: JSONDecoder.mongoDecoder)
    }
    
    func get<T: Content>(
        client: Client,
        db: MongoDatabase,
        user: User? = nil,
        headers: HTTPHeaders,
        server: ServerRepo,
        path: CustomStringConvertible
    ) async throws -> T {
        var authCredentials: [ClientCredentials] = []
        
        if let user = user {
            let userCredentials = try await user.ensureClientCredentials(
                client: client, db: db, headers: headers, server: server)
            authCredentials.append(userCredentials)
        }
        
        let headers = try server.requestAuthHeaders(headers: headers, credentials: authCredentials)
        let uri = server.uri(path: path)
        
        return try await self.get(client, uri: uri, headers: headers)
            .validate(type: NoError.self)
            .value(using: JSONDecoder.mongoDecoder)
    }
}
