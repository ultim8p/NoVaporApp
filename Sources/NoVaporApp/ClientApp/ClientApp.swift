//
//  ClientApp.swift
//
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import NoMongo
import Vapor
import MongoKitten
import NoServerAuth
import NoVaporError

public final class ClientApp: Content, DBCollectionable, Credentialable {
    
    public var _id: ObjectId?
    
    public var dateCreated: Date?
    
    public var dateUpdated: Date?
    
    public var identifier: String?
    
    public static var entityName: String = "clientApp"
    
    public init(_id: ObjectId? = nil, dateCreated: Date? = nil, dateUpdated: Date? = nil, identifier: String? = nil) {
        self._id = _id
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.identifier = identifier
    }
}

public extension ClientApp {
    
    func validateValues() throws {
        guard _id != nil, dateCreated != nil, dateUpdated != nil,
              identifier != nil
        else { throw NoError.noServerApp(reason: "Validating App", code: .validation) }
    }
}

public extension ClientApp {
    
    func makeDefault() {
        if _id == nil { _id = ObjectId() }
        if dateCreated == nil { dateCreated = Date() }
        if dateUpdated == nil { dateUpdated = Date() }
    }
}

public extension ClientApp {
    
    static func build(identifier: String?) throws -> ClientApp {
        let app = ClientApp()
        app.makeDefault()
        app.identifier = identifier
        try app.validateValues()
        return app
    }
}
