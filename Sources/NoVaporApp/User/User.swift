//
//  User.swift
//  
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import Vapor
import MongoKitten
import NoMongo
import NoServerAuth
import NoVaporError

public final class User: Content, DBCollectionable, Credentialable {
    
    public var _id: ObjectId?
    
    public var dateCreated: Date?
    
    public var dateUpdated: Date?
    
    public var email: String?
    
    public static var entityName: String = "user"
    
    public init(
        _id: ObjectId? = nil,
        dateCreated: Date? = nil,
        dateUpdated: Date? = nil
    ) {
        self._id = _id
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
    }
    
    static func createIndexes(in db: MongoDatabase) async throws {
        let collection = User.collection(in: db)
        try await collection.createIndex(named: "app._id,user._id", keys: [
            "app._id": 1,
            "user._id": 1
        ])
    }
}

public extension User {
    
    func requireId() throws -> ObjectId {
        guard let id = _id else { throw NoError.noVaporAppError(reason: "Missing userId", code: nil, fields: nil) }
        return id
    }
}

public extension User {
    
    func makeDefault() {
        if _id == nil { _id = ObjectId() }
        if dateCreated == nil { self.dateCreated = Date() }
        if dateUpdated == nil { self.dateUpdated = Date() }
    }
}

public extension User {
    
    func validateValues() throws {
        guard _id != nil, dateCreated != nil, dateUpdated != nil
        else { throw NoError.noVaporAppError(reason: "Missing values User", code: .missingValues) }
    }
}

public extension User {
    
    static func build(user: User? = nil) throws -> User {
        let usr = User()
        usr.makeDefault()
        usr._id = user?._id
        usr.makeDefault()
        try usr.validateValues()
        return usr
    }
}
