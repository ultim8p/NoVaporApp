//
//  File.swift
//  
//
//  Created by Guerson Perez on 31/07/24.
//

import Foundation

extension Date {
    
    func adding(milliseconds: Int) -> Date {
        return addingTimeInterval(TimeInterval(milliseconds) / 1000.0)
    }
}

extension Date {
    
    func milliseconds(from date: Date) -> Double {
        return self.timeIntervalSince(date) * 1000
    }
}
