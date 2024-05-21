//
//  File.swift
//  
//
//  Created by Guerson Perez on 12/21/23.
//

import Foundation
import NoVaporError

public extension NoError {
    static func noServerApp(reason: String? = nil, code: NoError.Code? = nil, fields: [String]? = nil) -> NoError {
        NoError.create(
            domain: "NoServerApp",
            reason: reason,
            code: code,
            fields: fields
        )
    }
}
