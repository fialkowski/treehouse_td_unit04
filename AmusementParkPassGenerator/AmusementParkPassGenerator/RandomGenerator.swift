//
//  RandomGenerator.swift
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
    
    static func randomKey(length: Int) -> String? {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        switch Int.random(in: 0...30) { // One of 30 will generate nil value for testing purpose
        case 0: return nil
        default: return String((0..<length).map{ _ in letters.randomElement()!})
        }
    }
    
    static func randomStreetNumber() -> Int? {
        var streetNumber: Int?
            switch Int.random(in: 0...30) { // One of 30 will generate nil value for testing purpose
            case 0: streetNumber = nil
            default: streetNumber = Int.random(in: 1000...20000)
            }
        return streetNumber
    }
    
    static func randomZipCode() -> String? {
        var zipCode: String?
        switch Int.random(in: 0...30) { // One of 30 will generate nil value for testing purpose
        case 0: zipCode = nil
        default: zipCode = String(format: "%05d", Int.random(in: 2801 ... 99950))
        }
        return zipCode
    }
    
    static func randomEmployeeCard() -> (PaymentTerms, Department) {
            let dept: Department = Department.allCases.randomElement()!
            var employeeType: PaymentTerms
            
            if dept == .office {
                employeeType = .payroll
            } else {
                employeeType = .hourly
            }
            return (employeeType, dept)
    }
    
    private static func retriveNamesFrom(file: String, ofType type: String) throws -> [String] {
        var retrivedNames = [String]()
        
        guard let path = Bundle.main.path(forResource: file, ofType: type) else {
            throw FileReadError.invalidResource
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else { //A TYPE CASTING HAPPENS HERE
            throw FileReadError.conversionFailure
        }
        
        for element in dictionary {
            if let value = element.value as? String, !value.isEmpty {
                retrivedNames.append(value)
            } else {
                retrivedNames.append(element.key)
            }
        }
        return retrivedNames
    }
    
    static func randomElementFrom(file: String, ofType type: String) -> String? {
        var names: [String?]
        do {
            names = try retriveNamesFrom(file: file, ofType: type)
        } catch let error {
            fatalError("\(error)")
        }
        if names.isEmpty {
            fatalError("Sorry, we found an empty file!")
        }
        switch Int.random(in: 0...30) { // One of 30 will generate nil value for testing purpose
        case 0: return nil
        default: return names[Int.random(in: 0...names.count - 1)]
        }
    }
}
