//
//  Protocols.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//
import Foundation


// MARK: -PassReaders defining protocols-------------------------
// The main protocol for a Class/Struct to be a pass------------------------------------------------------------------------------------------------------
//⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️

protocol PassReader { // General protocol that we use to define any pass reader. Will be used as Data type.
    var key: String { get }
    func printSelfToConsole()
}

protocol AreaAssignable {
    var areaType: Area { get }
}

protocol CashRegisterAssignable {
    var storeType: Good { get }
}

//⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️



// MARK: -ParkAdmissable protocol related------------------------
// The main protocol for a Class/Struct to be a pass------------------------------------------------------------------------------------------------------
//⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️

enum Area: String, CaseIterable {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

protocol ParkAdmissable {
    var key: String { get }
    var lastSwipeTimestamp: Date { get set }
    var admissionAreas: [Area] { get }
    func printSelfToConsole()
    mutating func swipe (reader: PassReader)
}

extension ParkAdmissable { // This extention contains computed array, that always returns the right admission areas as per objective
    var admissionAreas: [Area] {
        var admissionAreas = [Area]()
        admissionAreas.append(.amusement)
        if self is EmployeePass {
            let employee = self as! EmployeePass
            if employee.employeeCard.paymentTerms == .payroll {
                admissionAreas += [.kitchen, .rideControl, .maintenance, .office]
            } else if employee.employeeCard.paymentTerms == .hourly {
                switch employee.employeeCard.department {
                case .foodServices : admissionAreas.append(.kitchen)
                case .rideServices: admissionAreas.append(.rideControl)
                case .parkMaintenance: admissionAreas += [.kitchen, .rideControl, .maintenance]
                default : break
                }
            }
        }
        return admissionAreas
    }
    
    mutating func swipe(reader: PassReader) { // This method checks if a Pass istance has an access to a passed in pass reader
        reader.printSelfToConsole()
        self.printSelfToConsole()
        if let areaReader = reader as? AreaAssignable {
            if !self.admissionAreas.contains(areaReader.areaType) {
                ConsolePrinter.printAreaSwipeResult(self, printOut: .denied)
            } else if Date(timeIntervalSinceNow: -5) <= self.lastSwipeTimestamp {
                ConsolePrinter.printAreaSwipeResult(self, printOut: .tailGated)
            } else {
                ConsolePrinter.printAreaSwipeResult(self, printOut: .granted)
            }
        } else if let cashRegisterReader = reader as? CashRegisterAssignable, let selfDiscountable = self as? Discountable {
            ConsolePrinter.printCashRegisterSwipeResult(selfDiscountable, forCashRegisterPassReader: cashRegisterReader)
        }
        lastSwipeTimestamp = Date(timeIntervalSinceNow: 0)
    }
}
//⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️


// MARK: -RideAdmissable protocol related------------------------
// This protocol used to apply Ride Admission properties--------------
//⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️

protocol Child {
    var birthDate: Date { get }
}
//⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️


// MARK: -RideAdmissable protocol related------------------------
// This protocol used to apply Ride Admission properties--------------
//⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️

enum RideAdmission: String {
    case general
    case vip
}

protocol RideAdmissable {
    var rideAdmissionType: RideAdmission { get }
}

extension RideAdmissable {
    var rideAdmissionType: RideAdmission {
        if self is VipGuestPassObsolete {
            return .vip
        } else {
            return .general
        }
    }
}
//⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️


// MARK: -Discountable protocol related--------------------------
// This protocol used to apply Discount properties to a pass--------------
//⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️
enum Good: String, CaseIterable {
    case food
    case mercandise
}

protocol Discountable {
    typealias Discount = (value: Int, goodsGroup: Good)
    var discounts: [Discount] { get }
}

extension Discountable {
    var discounts: [Discount] {
        var discounts = [Discount]()
        if self is VipGuestPassObsolete {
            discounts.append((value: 10, goodsGroup: .food))
            discounts.append((value: 20, goodsGroup: .mercandise))
        } else if self is EmployeePass {
            let employee = self as? EmployeePass
            if employee?.employeeCard.0 == .hourly {
                discounts.append((value: 15, goodsGroup: .food))
                discounts.append((value: 25, goodsGroup: .mercandise))
            } else if employee?.employeeCard.0 == .payroll {
                discounts.append((value: 15, goodsGroup: .food))
                discounts.append((value: 25, goodsGroup: .mercandise))
            }
        }
        return discounts
    }
}
//⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️


// MARK: -Worker protocol related--------------------------
// This protocol used to apply an Employee properties to a pass--------------
//⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️

enum PaymentTerms: String, CaseIterable {
    case hourly
    case payroll
}

enum Department: String, CaseIterable {
    case foodServices
    case rideServices
    case parkMaintenance
    case office
}

protocol Worker {
    typealias EmployeeCard = (paymentTerms: PaymentTerms, department: Department)
    var employeeCard: EmployeeCard { get }
    var firstName: String { get }
    var lastName: String { get }
    var streetNumber: Int { get }
    var streetName: String { get }
    var city: String { get }
    var state: String { get }
    var zip: String { get }
}

extension Worker {
    var fullName: String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    var fullAddress: String {
        return "\(self.streetNumber) \(self.streetName), \(self.city), \(self.state) \(self.zip)"
    }
}
//⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️
