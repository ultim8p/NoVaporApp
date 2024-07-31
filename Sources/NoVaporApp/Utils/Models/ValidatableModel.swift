//
//  ValidatableModel.swift
//
//
//  Created by Guerson Perez on 31/07/24.
//

import Foundation

public protocol ValidatableModel {
    
    func validateValues() throws
}

public extension Array where Element: ValidatableModel {
    
    func validateValues() throws {
        try forEach({ try $0.validateValues() })
    }
}
