//
//  PassStructs.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-14.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation

enum PassInitError: Error {
    case invalidKey(throwingInstance: String)
    case invalidBirthDate(throwingInstance: String)
    case invalidFirstName(throwingInstance: String)
    case invalidLastName(throwingInstance: String)
    case invalidStreetNumber(throwingInstance: String)
    case invalidStreetName(throwingInstance: String)
    case invalidCity(throwingInstance: String)
    case invalidState(throwingInstance: String)
    case invalidZip(throwingInstance: String)
    case invalidEmployeeCard(throwingInstance: String)
}

struct Classic: ParkAdmissable, RideAdmissable {
    let key: String
    var lastSwipeTimestamp: Date
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() throws {
        guard let unwrappedKey = RandomGenerator.randomKey(length: 32) else { // Generates a random key for the instance
            throw PassInitError.invalidKey(throwingInstance: String(describing: Classic.self))
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
    
    init() throws {
        guard let unwrappedKey = RandomGenerator.randomKey(length: 32) else { // Generates a random key for the instance
            throw PassInitError.invalidKey(throwingInstance: String(describing: Vip.self))
        }
        self.key = unwrappedKey
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
    init() throws {
        guard let unwrappedKey = RandomGenerator.randomKey(length: 32) else { // Generates a random key for the instance
            throw PassInitError.invalidKey(throwingInstance: String(describing: FreeChild.self))
        }
        self.key = unwrappedKey
        guard let unwrappedBirthDate = RandomGenerator.randomDate(daysBack: 5200) else {
            throw PassInitError.invalidBirthDate(throwingInstance: String(describing: FreeChild.self))
        }
        self.birthDate = unwrappedBirthDate
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
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
    
    init() throws { // THIS INIT GENERATES RANDOM DATA FOR THE STRUCT
        guard let unwrappedKey = RandomGenerator.randomKey(length: 32) else { // Generates a random key for the instance
            throw PassInitError.invalidKey(throwingInstance: String(describing: Employee.self))
        }
        self.key = unwrappedKey
        
        guard let unwrappedFirstName = RandomGenerator.randomElementFrom(file: "firstNames", ofType: "plist") else { //Grabs a random string from the plist as a first name
            throw PassInitError.invalidFirstName(throwingInstance: String(describing: Employee.self))
        }
        self.firstName = unwrappedFirstName
        
        guard let unwrappedLastName = RandomGenerator.randomElementFrom(file: "lastNames", ofType: "plist") else { //Grabs a random string from the plist as a last name
            throw PassInitError.invalidLastName(throwingInstance: String(describing: Employee.self))
        }
        self.lastName = unwrappedLastName
        
        guard let unwrappedStreetNumber = RandomGenerator.randomStreetNumber() else {
            throw PassInitError.invalidStreetNumber(throwingInstance: String(describing: Employee.self))
        }
        self.streetNumber = unwrappedStreetNumber
        
        guard let unwrappedStreetName = RandomGenerator.randomElementFrom(file: "streetNames", ofType: "plist"),         //Grabs a random string from the plist as a street name
              let unwrappedStreetType = RandomGenerator.randomElementFrom(file: "streetTypes", ofType: "plist") else {   //Grabs a random string from the plist as a street name
                    throw PassInitError.invalidStreetName(throwingInstance: String(describing: Employee.self))
        }
        self.streetName = "\(unwrappedStreetName) " + "\(unwrappedStreetType)"
        
        guard let unwrappedCity = RandomGenerator.randomElementFrom(file: "cities", ofType: "plist") else { //Grabs a random string from the plist as a city
            throw PassInitError.invalidCity(throwingInstance: String(describing: Employee.self))
        }
        self.city = unwrappedCity
        
        guard let unwrappedState = RandomGenerator.randomElementFrom(file: "states", ofType: "plist") else { //Grabs a random string from the plist as a state
            throw PassInitError.invalidState(throwingInstance: String(describing: Employee.self))
        }
        self.state = unwrappedState
        
        guard let unwrappedZip = RandomGenerator.randomZipCode() else {
            throw PassInitError.invalidZip(throwingInstance: String(describing: Employee.self))
        }
        self.zip = unwrappedZip
        
        self.employeeCard = RandomGenerator.randomEmployeeCard() //Generates a random employye card
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
    }
}
