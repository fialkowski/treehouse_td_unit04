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
    case emptyBirthDate
    case invalidSsn(throwingInstance: String)
    case wrongLengthSsn
    case invalidFirstName(throwingInstance: String)
    case emptyFirstName
    case invalidLastName(throwingInstance: String)
    case emptyLastName
    case invalidStreetNumber(throwingInstance: String)
    case emptySreetNumber
    case invalidStreetName(throwingInstance: String)
    case emptyStreetName
    case invalidStreetType(throwingInstance: String)
    case emptyStreetType
    case invalidCity(throwingInstance: String)
    case emptyCity
    case invalidState(throwingInstance: String)
    case emptyState
    case invalidZip(throwingInstance: String)
    case emptyZip
    case invalidEmployeeCard(throwingInstance: String)
    case invalidPaymentTerms(throwingInstance: String)
    case invalidDepartment(throwingInstance: String)
}

struct AdultGuestPassObsolete: ParkAdmissable, RideAdmissable {
    let key: String
    var lastSwipeTimestamp: Date
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() throws {
        self.key = RandomGenerator.randomPassKey
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
    }
    
}

struct VipGuestPassObsolete: ParkAdmissable, RideAdmissable, Discountable {
    let key: String
    var lastSwipeTimestamp: Date
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() throws {
        self.key = RandomGenerator.randomPassKey
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
    }
    
}

struct ChildGuestPassObsolete: ParkAdmissable, Child, RideAdmissable {
    let key: String
    var lastSwipeTimestamp: Date
    let birthDate: Date
    
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    init() throws {
        self.key = RandomGenerator.randomPassKey
        guard let unwrappedBirthDate = RandomGenerator.randomDate(daysBack: 5200) else {
            throw PassInitError.invalidBirthDate(throwingInstance: String(describing: ChildGuestPassObsolete.self))
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

struct EmployeePass: ParkAdmissable, Worker, RideAdmissable, Discountable {
    let key: String
    let ssn: String
    let firstName: String
    let lastName: String
    let streetNumber: Int
    let streetName: String
    let streetType: String
    let city: String
    let state: String
    let zip: String
    var employeeCard: EmployeeCard
    var lastSwipeTimestamp: Date
    
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init(key: String?,
         ssn: String?,
         firstName: String?,
         lastName: String?,
         streetNumber: Int?,
         streetName: String?,
         streetType: String?,
         city: String?,
         state: String?,
         zip: String?,
         paymentTerms: PaymentTerms?,
         department: Department?) throws {
        self.key = RandomGenerator.randomPassKey
        
        guard let unwrappedSsn = ssn else { throw PassInitError.invalidSsn(throwingInstance: String(describing: EmployeePass.self))}
        if unwrappedSsn.count != 9 {
            throw PassInitError.wrongLengthSsn
        } else {
            self.ssn = unwrappedSsn
        }
        
        guard let unwrappedFirstName = firstName else { throw PassInitError.invalidFirstName(throwingInstance: String(describing: EmployeePass.self)) }
        if unwrappedFirstName.count == 0 {
            throw PassInitError.emptyFirstName
        } else {
            self.firstName = unwrappedFirstName
        }
        
        guard let unwrappedLastName = lastName else { throw PassInitError.invalidLastName(throwingInstance: String(describing: EmployeePass.self)) }
        if unwrappedLastName.count == 0 {
            throw PassInitError.emptyLastName
        } else {
            self.lastName = unwrappedLastName
        }
        
        guard let unwrappedStreetNumber = streetNumber else { throw PassInitError.invalidStreetNumber(throwingInstance: String(describing: EmployeePass.self)) }
        self.streetNumber = unwrappedStreetNumber
        
        guard let unwrappedStreetName = streetName else { throw PassInitError.invalidStreetName(throwingInstance: String(describing: EmployeePass.self))}
        if unwrappedStreetName.count == 0 {
            throw PassInitError.emptyStreetName
        } else {
            self.streetName = unwrappedStreetName
        }
        
        guard let unwrappedStreetType = streetType else {throw PassInitError.invalidStreetType(throwingInstance: String(describing: EmployeePass.self))}
        if unwrappedStreetType.count == 0 {
            throw PassInitError.emptyStreetType
        } else {
            self.streetType = unwrappedStreetType
        }
        
        guard let unwrappedCity = city else { throw PassInitError.invalidCity(throwingInstance: String(describing: EmployeePass.self))}
        if unwrappedCity.count == 0 {
            throw PassInitError.emptyCity
        } else {
            self.city = unwrappedCity
        }
        
        guard let unwrappedState = state else { throw PassInitError.invalidState(throwingInstance: String(describing: EmployeePass.self))}
        if unwrappedState.count == 0 {
            throw PassInitError.emptyState
        } else {
            self.state = unwrappedState
        }
        
        guard let unwrappedZip = zip else { throw PassInitError.invalidZip(throwingInstance: String(describing: EmployeePass.self))}
        if unwrappedZip.count == 0 {
            throw PassInitError.emptyZip
        } else {
            self.zip = unwrappedZip
        }
        
        guard let unwrappedPaymentTerms = paymentTerms else { throw PassInitError.invalidPaymentTerms(throwingInstance: String(describing: EmployeePass.self))}
        guard let unwrappedDepartment = department else { throw PassInitError.invalidPaymentTerms(throwingInstance: String(describing: EmployeePass.self))}
        self.employeeCard = (paymentTerms: unwrappedPaymentTerms, department: unwrappedDepartment)
        
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
    }
    
    init() throws { // THIS INIT GENERATES RANDOM DATA FOR THE STRUCT
        self.key = RandomGenerator.randomPassKey
        self.ssn = RandomGenerator.randomSsn
        
        guard let unwrappedFirstName = RandomGenerator.randomElementFrom(file: "firstNames", ofType: "plist") else { //Grabs a random string from the plist as a first name
            throw PassInitError.invalidFirstName(throwingInstance: String(describing: EmployeePass.self))
        }
        self.firstName = unwrappedFirstName
        
        guard let unwrappedLastName = RandomGenerator.randomElementFrom(file: "lastNames", ofType: "plist") else { //Grabs a random string from the plist as a last name
            throw PassInitError.invalidLastName(throwingInstance: String(describing: EmployeePass.self))
        }
        self.lastName = unwrappedLastName
        
        guard let unwrappedStreetNumber = RandomGenerator.randomStreetNumber() else {
            throw PassInitError.invalidStreetNumber(throwingInstance: String(describing: EmployeePass.self))
        }
        self.streetNumber = unwrappedStreetNumber
        
        guard let unwrappedStreetName = RandomGenerator.randomElementFrom(file: "streetNames", ofType: "plist") else {
                    throw PassInitError.invalidStreetName(throwingInstance: String(describing: EmployeePass.self))
        }
        
        guard let unwrappedStreetType = RandomGenerator.randomElementFrom(file: "streetTypes", ofType: "plist") else { throw PassInitError.invalidStreetType(throwingInstance: String(describing: EmployeePass.self))}
        self.streetName = unwrappedStreetName
        self.streetType = unwrappedStreetType
        
        guard let unwrappedCity = RandomGenerator.randomElementFrom(file: "cities", ofType: "plist") else { //Grabs a random string from the plist as a city
            throw PassInitError.invalidCity(throwingInstance: String(describing: EmployeePass.self))
        }
        self.city = unwrappedCity
        
        guard let unwrappedState = RandomGenerator.randomElementFrom(file: "states", ofType: "plist") else { //Grabs a random string from the plist as a state
            throw PassInitError.invalidState(throwingInstance: String(describing: EmployeePass.self))
        }
        self.state = unwrappedState
        
        guard let unwrappedZip = RandomGenerator.randomZipCode() else {
            throw PassInitError.invalidZip(throwingInstance: String(describing: EmployeePass.self))
        }
        self.zip = unwrappedZip
        
        self.employeeCard = RandomGenerator.randomEmployeeCard() //Generates a random employye card
        self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
    }
}

