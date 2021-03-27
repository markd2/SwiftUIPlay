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

    static var firstNames: [String] = {
        print("Snorgle")
        return ["hello", "snorgle", "oop"]
    }()

    static var lastNames: [String] = {
        print("Snorgle2")
        return ["hello2", "greeble", "bork"]
    }()

    static func random(count: Int) -> [Person] {
        (0 ..< count).map { _ in
            Person(bloodType: BloodType.allCases.randomElement()!, 
                   shoeSize: 13, 
                   name: firstNames.randomElement()! + " " + lastNames.randomElement()!) 
            }
    }
}

extension Person: Hashable, Equatable {}
extension Person.BloodType: CaseIterable {}

extension Person: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(name) : \(bloodType.rawValue) size \(shoeSize)"
    }
}
