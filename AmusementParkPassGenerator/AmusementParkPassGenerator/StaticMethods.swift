//
//  StaticMethods.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-03-22.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation

enum FileReadError: Error {
    case invalidResource
    case conversionFailure
    case wrongElementType
}

class RandomGenerator {
    static func randomDate(daysBack: Int)-> Date?{
        let day = Int(arc4random_uniform(UInt32(daysBack) + 1)) * -1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
    
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = day - 1
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0))
        return randomDate
    }
    
    static func randomKey(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

class NamesRetriever {
    static func randomElement(fromFile name: String, ofType type: String) throws -> String {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw FileReadError.invalidResource
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else { //A TYPE CASTING HAPPENS HERE
            throw FileReadError.conversionFailure
        }
        guard let randomElement = dictionary.randomElement() else {
            throw FileReadError.wrongElementType
        }
        if let output = randomElement.value as? [String] {
            if !output.isEmpty {
                return output.first!
            } else {
                return randomElement.key
            }
        } else {
            return randomElement.key
        }
    }
}
