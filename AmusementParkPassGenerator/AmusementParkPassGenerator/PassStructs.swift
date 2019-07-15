//
//  PassStructs.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-14.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation

enum PassInitError: Error {
    case invalidKey
    case invalidBirthDate
    case invalidFirstName
    case invalidLastName
    case invalidStreetNumber
    case invalidStreetName
    case invalidCity
    case invalidState
    case invalidZip
    case invalidEmployeeCard
}

struct Classic: ParkAdmissable, RideAdmissable {
    let key: String
    var lastSwipeTimestamp: Date
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() throws {
        guard let unwrappedKey = RandomGenerator.randomKey(length: 32) else { // Generates a random key for the instance
            throw PassInitError.invalidKey
        }
        self.key = unwrappedKey
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
    }
    
}

struct Vip: ParkAdmissable, RideAdmissable, Discountable {
    let key: String
    var lastSwipeTimestamp: Date
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() {
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
    }
    
}

struct FreeChild: ParkAdmissable, Child, RideAdmissable {
    let key: String
    var lastSwipeTimestamp: Date
    let birthDate: Date
    
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() {
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.birthDate = RandomGenerator.randomDate(daysBack: 5200) ?? Date(timeIntervalSince1970: 0) // Generates a random date within 5200 days back from today
        
        /* FIXED DATE ASSIGNING BLOCK FOR TESTING
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy/MM/dd HH:mm"
         self.birthDate = formatter.date(from: "2001/04/11 22:31")!
         */
    }
}

struct Employee: ParkAdmissable, Worker, RideAdmissable, Discountable {
    let key: String
    var lastSwipeTimestamp: Date
    let firstName: String
    let lastName: String
    let streetNumber: Int
    let streetName: String
    let city: String
    let state: String
    let zip: String
    var employeeCard: EmployeeCard
    
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() { // THIS INIT GENERATES RANDOM DATA FOR THE STRUCT
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.firstName = RandomGenerator.randomElementFrom(file: "firstNames", ofType: "plist") //Grabs a random string from the plist as a first name
        self.lastName = RandomGenerator.randomElementFrom(file: "lastNames", ofType: "plist") //Grabs a random string from the plist as a last name
        self.streetNumber = Int.random(in: 1000...20000) //Generates a random integer within a given range
        self.streetName = "\(RandomGenerator.randomElementFrom(file: "streetNames", ofType: "plist")) " //Grabs a random string from the plist as a street name
            + "\(RandomGenerator.randomElementFrom(file: "streetTypes", ofType: "plist"))" //Grabs a random string from the plist as a street type
        self.city = RandomGenerator.randomElementFrom(file: "cities", ofType: "plist") //Grabs a random string from the plist as a city
        self.state = RandomGenerator.randomElementFrom(file: "states", ofType: "plist") //Grabs a random string from the plist as a state
        self.zip = String(format: "%05d", Int.random(in: 2801 ... 99950)) //Generates a random integer within a given range and format
        self.employeeCard = RandomGenerator.randomEmployeeCard() //Generates a random employye card
    }
}
