//
//  PassDataTypes.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-24.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation

protocol PassCoreData {
    var key: String { get }
    var lastSwipeTimestamp: Date { get set }
    var admissionAreas: [Area] { get }
    mutating func swipe (reader: PassReader) -> AccessPermission
}

extension PassCoreData {
    mutating func swipe(reader: PassReader) -> AccessPermission { // This method checks if a Pass istance has an access to a passed in pass reader
        if let areaReader = reader as? AreaAssignable {
            if self.admissionAreas.contains(areaReader.areaType) && Date(timeIntervalSinceNow: -5) <= self.lastSwipeTimestamp {
                return AccessPermission.deniedDoubleSwipeAttempt
            } else if self.admissionAreas.contains(areaReader.areaType) {
                return AccessPermission.granted
            } else {
                return AccessPermission.deniedNoPermission
            }
        }
        lastSwipeTimestamp = Date(timeIntervalSinceNow: 0)
        return AccessPermission.deniedNoPermission
    }
}

enum RideAccessOrder {
    case general, skipsLine
    
    var engUsCaptions: String {
        switch self {
        case .general: return "General, no Ride Line Skipping"
        case .skipsLine: return "Priority Access, Skips Ride Lines"
        }
    }
}

protocol RideAccessOrderData {
    var rideAccessOrder: RideAccessOrder { get }
}

enum AccessPermission: String {
    case granted, deniedNoPermission, deniedDoubleSwipeAttempt
    
    var engUsCaptions: String {
        switch self {
        case .granted: return "Access granted"
        case .deniedNoPermission: return "Access Denied No Access Permission"
        case .deniedDoubleSwipeAttempt: return "Access Denied, Double Swipe Attempt"
        }
    }
}

protocol PassBirthDateDetailsData: PassCoreData {
    var birthDate: Date { get }
}

protocol PassNameDetailsData: PassBirthDateDetailsData {
    var firstName: String { get }
    var lastName: String { get }
}

protocol PassAddressDetailsData: PassNameDetailsData {
    var streetNumber: String { get }
    var streetName: String { get }
    var streetType: String { get }
    var city: String { get }
    var state: String { get }
    var zip: String { get }
}

protocol PassSsnDetailsData: PassAddressDetailsData {
    var ssn: String { get }
}

enum ItemGroup: String, CaseIterable {
    case food, merchandise
}

protocol DiscountData {
    typealias Discount = (discout: Float, itemGroup: ItemGroup)
    var discounts: [Discount] { get }
}

protocol AdultGuestPassData: PassCoreData, RideAccessOrderData {
    init (admissionAreas: [Area],
          rideAccessOrder: RideAccessOrder) throws
}

protocol VipGuestPassData: PassCoreData, DiscountData, RideAccessOrderData {
    init (admissionAreas: [Area],
          discounts: [Discount],
          rideAccessOrder: RideAccessOrder)
}

protocol ChildGuestPassData: PassBirthDateDetailsData, RideAccessOrderData {
    init (admissionAreas: [Area],
          birthDate: Date,
          rideAccessOrder: RideAccessOrder)
}

protocol SeniorGuestPassData: PassNameDetailsData, DiscountData, RideAccessOrderData {
    init (admissionAreas: [Area], discounts: [Discount],
          firstName: String, lastName: String,
          birthDate: Date, rideAccessOrder: RideAccessOrder)
}

protocol SeasonGuestPassData: PassAddressDetailsData, DiscountData, RideAccessOrderData {
    init (admissionAreas: [Area], discounts: [Discount],
          firstName: String, lastName: String,
          streetNumber: String, streetName: String,
          streetType: String, city: String,
          state: String, zip: String,
          birthDate: Date, rideAccessOrder: RideAccessOrder)
}

enum HourlyEmployeeDepartment {
    case foodServices, rideServices, maintenance
    
    var engUsCaptions: String {
        switch self {
        case .foodServices: return "Food Services"
        case .rideServices: return "Ride Services"
        case .maintenance: return "Maintenance"
        }
    }
}

protocol HourlyEmployeePassData: PassSsnDetailsData, DiscountData, RideAccessOrderData {
    var department: HourlyEmployeeDepartment { get }
    init (admissionAreas: [Area], discounts: [Discount],
          ssn: String, department: HourlyEmployeeDepartment,
          firstName: String, lastName: String,
          streetNumber: String, streetName: String,
          streetType: String, city: String,
          state: String, zip: String,
          birthDate: Date, rideAccessOrder: RideAccessOrder)
}

enum ProjectNumber: CaseIterable {
    case num1001, num1002, num1003, num2001, num2002
    
    var engUsCaptions: String {
        switch self {
        case .num1001: return "1001"
        case .num1002: return "1002"
        case .num1003: return "1003"
        case .num2001: return "2001"
        case .num2002: return "2002"
        }
    }
}

protocol ContractEmployeePassData: PassSsnDetailsData {
    var projectNumber: ProjectNumber { get }
    init (admissionAreas: [Area], birthDate: Date,
          ssn: String, projectNumber: ProjectNumber,
          firstName: String, lastName: String,
          streetNumber: String, streetName: String,
          streetType: String, city: String,
          state: String, zip: String)
}

enum ManagementTier: CaseIterable {
    case shift, general, senior
    
    var engUsCaptions: String {
        switch self {
        case .shift: return "Shift Manager"
        case .general: return "General Manager"
        case .senior: return "Senior Manager"
        }
    }
}

protocol ManagerPassData: PassSsnDetailsData, DiscountData, RideAccessOrderData {
    var managementTier: ManagementTier { get }
    init (admissionAreas: [Area], discounts: [Discount],
          ssn: String, managementTier: ManagementTier,
          firstName: String, lastName: String,
          streetNumber: String, streetName: String,
          streetType: String, city: String,
          state: String, zip: String,
          birthDate: Date, rideAccessOrder: RideAccessOrder)
}

enum VendorCompany: CaseIterable {
    case acme, orkin, fedex, nwElectrical
    
    var engUsCaptions: String {
        switch self {
        case .acme: return "Acme"
        case .orkin: return "Orkin"
        case .fedex: return "FedEx"
        case .nwElectrical: return "NW Electrical"
        }
    }
}

protocol VendorPassData: PassNameDetailsData {
    var company: VendorCompany { get }
    var visitDate: Date { get }
    
    init (admissionAreas: [Area], company: VendorCompany,
          firstName: String, lastName: String,
          birthDate: Date, visitDate: Date)
}

enum AdultGuestPassError: Error {
    case invalidArea, invalidRideAccessOrder
}

struct AdultGuestPass: AdultGuestPassData {
    let key: String;                       let admissionAreas: [Area]
    let rideAccessOrder: RideAccessOrder;  var lastSwipeTimestamp: Date
    
    init(admissionAreas: [Area], rideAccessOrder: RideAccessOrder) {
        self.key = RandomGenerator.randomPassKey; self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.admissionAreas = admissionAreas;     self.rideAccessOrder = rideAccessOrder
    }
}

struct ChildGuestPass: ChildGuestPassData {
    let key: String;                       let admissionAreas: [Area]
    let rideAccessOrder: RideAccessOrder;  let birthDate: Date
    var lastSwipeTimestamp: Date
    
    init(admissionAreas: [Area], birthDate: Date, rideAccessOrder: RideAccessOrder) {
        
        self.key = RandomGenerator.randomPassKey;   self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.admissionAreas = admissionAreas;       self.birthDate = birthDate
        self.rideAccessOrder = rideAccessOrder
    }
} 

struct VipGuestPass: VipGuestPassData {
    let key: String;              let admissionAreas: [Area]
    let discounts: [Discount];    let rideAccessOrder: RideAccessOrder
    var lastSwipeTimestamp: Date
    
    init(admissionAreas: [Area], discounts: [Discount], rideAccessOrder: RideAccessOrder) {
        
        self.key = RandomGenerator.randomPassKey;   self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.admissionAreas = admissionAreas;       self.rideAccessOrder = rideAccessOrder
        self.discounts = discounts
    }
}

struct SeniorGuestPass: SeniorGuestPassData {
    let key: String;              var lastSwipeTimestamp: Date
    let admissionAreas: [Area];   let discounts: [Discount]
    let firstName: String;        let lastName: String
    let birthDate: Date;          let rideAccessOrder: RideAccessOrder
    
    init(admissionAreas: [Area], discounts: [Discount],
         firstName: String,      lastName: String,
         birthDate: Date,        rideAccessOrder: RideAccessOrder) {
        
        self.key = RandomGenerator.randomPassKey;   self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.admissionAreas = admissionAreas;       self.discounts = discounts
        self.firstName = firstName;                 self.lastName = lastName
        self.birthDate = birthDate;                 self.rideAccessOrder = rideAccessOrder
    }
}

struct SeasonGuestPass: SeasonGuestPassData {
    let key: String;                var lastSwipeTimestamp: Date
    let discounts: [Discount];      let rideAccessOrder: RideAccessOrder
    let firstName: String;          let lastName: String
    let birthDate: Date;            let streetNumber: String
    let streetName: String;         let streetType: String
    let city: String;               let state: String
    let zip: String;                let admissionAreas: [Area]

    init(admissionAreas: [Area], discounts: [Discount],
         firstName: String,      lastName: String,
         streetNumber: String,   streetName: String,
         streetType: String,     city: String,
         state: String,          zip: String,
         birthDate: Date,        rideAccessOrder: RideAccessOrder) {
        
        self.key = RandomGenerator.randomPassKey; self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.admissionAreas = admissionAreas;     self.discounts = discounts
        self.rideAccessOrder = rideAccessOrder;   self.firstName = firstName
        self.lastName = lastName;                 self.birthDate = birthDate
        self.streetNumber = streetNumber;         self.streetName = streetName
        self.streetType = streetType;             self.city = city
        self.state = state;                       self.zip = zip
    }
}

struct HourlyEmployeePass: HourlyEmployeePassData {
    let key: String;                var lastSwipeTimestamp: Date
    let admissionAreas: [Area];     let ssn: String
    let discounts: [Discount];      let rideAccessOrder: RideAccessOrder
    let streetNumber: String;       let streetName: String
    let streetType: String;         let city: String
    let state: String;              let zip: String
    let firstName: String;          let lastName: String
    let birthDate: Date;            let department: HourlyEmployeeDepartment
    
    init(admissionAreas: [Area], discounts: [Discount],
         ssn: String,            department: HourlyEmployeeDepartment,
         firstName: String,      lastName: String,
         streetNumber: String,   streetName: String,
         streetType: String,     city: String,
         state: String,          zip: String,
         birthDate: Date,        rideAccessOrder: RideAccessOrder) {
        
        self.key = RandomGenerator.randomPassKey; self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.admissionAreas = admissionAreas;     self.ssn = ssn
        self.discounts = discounts;               self.rideAccessOrder = rideAccessOrder
        self.streetNumber = streetNumber;         self.streetName = streetName
        self.streetType = streetType;             self.city = city
        self.state = state;                       self.zip = zip
        self.firstName = firstName;               self.lastName = lastName
        self.birthDate = birthDate;               self.department = department
    }
}

struct ContractEmployeePass: ContractEmployeePassData {
    let key: String;                    var lastSwipeTimestamp: Date
    let admissionAreas: [Area];         let ssn: String
    let projectNumber: ProjectNumber;   let streetNumber: String
    let streetName: String;             let streetType: String
    let city: String;                   let state: String
    let zip: String;                    let firstName: String
    let lastName: String;               let birthDate: Date
    
    init(admissionAreas: [Area],    birthDate: Date,
         ssn: String,               projectNumber: ProjectNumber,
         firstName: String,         lastName: String,
         streetNumber: String,      streetName: String,
         streetType: String,        city: String,
         state: String,             zip: String) {
        
        self.key = RandomGenerator.randomPassKey;   self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.admissionAreas = admissionAreas;       self.ssn = ssn
        self.birthDate = birthDate;                 self.projectNumber = projectNumber
        self.streetNumber = streetNumber;           self.streetName = streetName
        self.streetType = streetType;               self.city = city
        self.state = state;                         self.zip = zip
        self.firstName = firstName;                 self.lastName = lastName
    }
}

struct ManagerPass: ManagerPassData {
    let key: String;                var lastSwipeTimestamp: Date
    let admissionAreas: [Area];     let ssn: String
    let discounts: [Discount];      let rideAccessOrder: RideAccessOrder
    let streetNumber: String;       let streetName: String
    let streetType: String;         let city: String
    let state: String;              let zip: String
    let firstName: String;          let lastName: String
    let birthDate: Date;            let managementTier: ManagementTier
    
    init(admissionAreas: [Area],    discounts: [Discount],
         ssn: String,               managementTier: ManagementTier,
         firstName: String,         lastName: String,
         streetNumber: String,      streetName: String,
         streetType: String,        city: String,
         state: String,             zip: String,
         birthDate: Date,           rideAccessOrder: RideAccessOrder) {
        
        self.key = RandomGenerator.randomPassKey;   self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
        self.admissionAreas = admissionAreas;       self.ssn = ssn
        self.discounts = discounts;                 self.rideAccessOrder = rideAccessOrder
        self.streetNumber = streetNumber;           self.streetName = streetName
        self.streetType = streetType;               self.city = city
        self.state = state;                         self.zip = zip
        self.firstName = firstName;                 self.lastName = lastName
        self.birthDate = birthDate;                 self.managementTier = managementTier
    }
}

struct VendorPass: VendorPassData {
    let key: String;                let admissionAreas: [Area]
    let company: VendorCompany;     let visitDate: Date
    let firstName: String;          let lastName: String
    let birthDate: Date;            var lastSwipeTimestamp: Date
 
    init(admissionAreas: [Area],    company: VendorCompany,
         firstName: String,         lastName: String,
         birthDate: Date,           visitDate: Date) {
        
        self.key = RandomGenerator.randomPassKey;   self.admissionAreas = admissionAreas
        self.company = company;                     self.visitDate = visitDate
        self.firstName = firstName;                 self.lastName = lastName
        self.birthDate = birthDate;                 self.lastSwipeTimestamp = Date(timeIntervalSinceNow: -9)
    }
}
