//
//  File.swift
//  
//
//  Created by Guerson Perez on 31/07/24.
//

import Foundation

public extension String {
    
    var base64Data: Data? {
        Data(base64Encoded: self)
    }
}
