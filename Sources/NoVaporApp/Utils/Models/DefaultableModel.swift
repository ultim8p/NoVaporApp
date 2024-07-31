//
//  DefaultableModel.swift
//
//
//  Created by Guerson Perez on 31/07/24.
//

import Foundation

public protocol DefaultableModel {
    
    func makeDefault()
}

public extension Array where Element: DefaultableModel {
    
    func makeDefault() {
        forEach({ $0.makeDefault() })
    }
}
