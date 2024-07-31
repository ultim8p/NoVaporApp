//
//  File.swift
//  
//
//  Created by Guerson Perez on 31/07/24.
//

import Foundation

public extension Date {
    
    func adding(milliseconds: Int) -> Date {
        return addingTimeInterval(TimeInterval(milliseconds) / 1000.0)
    }
}

public extension Date {
    
    func milliseconds(from date: Date) -> Double {
        return self.timeIntervalSince(date) * 1000
    }
}
