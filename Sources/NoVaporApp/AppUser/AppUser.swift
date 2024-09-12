//
//  AppUser.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import MongoKitten
import NoMongo
import Vapor
import NoVaporError

public final class AppUser: DBCollectionable, Content {
    
    public var _id: ObjectId?
    
    public var dateCreated: Date?
    
    public var dateUpdated: Date?
    
    public var app: ClientApp?
    
    public var user: User?
    
    static func createIndexes(in db: MongoDatabase) async throws {
        let collection = AppUser.collection(in: db)
        try await collection.createIndex(named: "app._id,user._id", keys: [
            "app._id": 1,
            "user._id": 1
        ])
    }
}

public extension AppUser {
    
    func makeDefault() {
        if _id == nil { _id = ObjectId() }
        if dateCreated == nil { dateCreated = Date() }
        if dateUpdated == nil { dateUpdated = Date() }
    }
}

public extension AppUser {
    
    func validateValues() throws {
        guard _id != nil, dateCreated != nil, dateUpdated != nil,
        app != nil, user != nil
        else { throw NoError.noServerApp(reason: "Missing values in AppUser", code: .validation) }
    }
}

public extension AppUser {
    
    static func ensureExists(db: MongoDatabase, app: ClientApp?, user: User?) async throws {
        guard try await findOptional(db: db, app: app, user: user) == nil
        else { return }
        let creatingObj = try AppUser.build(appId: app?._id, userId: user?._id)
        try await creatingObj.save(in: db)
    }
    
    static func findOptional(db: MongoDatabase, app: ClientApp?, user: User?) async throws -> AppUser? {
        guard let userId = user?._id, let appId = app?._id
        else { throw NoError.noServerApp(reason: "Missing values in AppUser", code: .missingValues) }
        return try await AppUser.findOneOptional(in: db, query: ["app._id": appId, "user._id": userId])
    }
    
    static func build(appId: ObjectId?,
                      userId: ObjectId?
    ) throws -> AppUser {
        let appUser = AppUser()
        appUser.makeDefault()
        appUser.app = ClientApp(_id: appId)
        appUser.user = User(_id: userId)
        try appUser.validateValues()
        return appUser
    }
}
