//
//  File.swift
//  
//
//  Created by Guerson Perez on 12/24/23.
//

import Foundation

public protocol UnknownCaseRepresentable: RawRepresentable, CaseIterable where RawValue: Equatable {
    static var unknownCase: Self { get }
}

public extension UnknownCaseRepresentable {
    init(rawValue: RawValue) {
        let value = Self.allCases.first(where: { $0.rawValue == rawValue })
        self = value ?? Self.unknownCase
    }
}
