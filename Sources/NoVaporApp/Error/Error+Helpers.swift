//
//  Error+Helpers.swift
//  
//
//  Created by Guerson Perez on 19/05/24.
//

import Foundation
import NoVaporError

extension NoError {
    
    static func noVaporAppError(
        reason: String? = nil,
        code: NoError.Code? = nil,
        fields: [String]? = nil
    ) -> NoError {
        NoError.create(
            domain: "NoVaporError",
            reason: reason,
            code: code,
            fields: fields
        )
    }
}
