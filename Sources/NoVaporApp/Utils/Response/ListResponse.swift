//
//  ListResponse.swift
//
//
//  Created by Guerson Perez on 31/07/24.
//

import Foundation
import Vapor

public final class ListResponse<T: Content>: Content {
    
    public var items: [T]?
    
    public init(items: [T]? = nil) {
        self.items = items
    }
}
