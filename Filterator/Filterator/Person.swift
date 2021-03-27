//
//  Person.swift
//  Filterator
//
//  Created by Mark Dalrymple on 3/27/21.
//

import Foundation

struct Person {
    enum BloodType: String {
        case A
        case B
        case AB
        case O
    }

    let bloodType: BloodType
    let shoeSize: Double
    let name: String

    static func random() -> Person {
        
    }
}

extension Person: Hashable, Equatable {}
extension Person.BloodType: CaseIterable {}

