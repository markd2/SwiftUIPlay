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


    static func readTextFile(named name: String) -> [String] {
        // quick and dirty utility, hence all the crash operators scattered around)
        let path = Bundle.main.url(forResource: name, withExtension: "txt")!
        let content = try! String(contentsOf: path, encoding: .utf8)
        let array = content.split(separator: "\n")
        return array.map{ String($0) }
    }

    static var firstNames: [String] = {
        readTextFile(named: "first-names")
    }()

    static var lastNames: [String] = {
        readTextFile(named: "last-names")
    }()

    static func randomShoeSize() -> Double {
        var size = Double((5...14).randomElement()!)
        if [true, false].randomElement()! {
            size += 0.5
        }
        return size
    }

    static func random(count: Int) -> [Person] {
        (0 ..< count).map { _ in
            Person(bloodType: BloodType.allCases.randomElement()!, 
                   shoeSize: randomShoeSize(),
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
