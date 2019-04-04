//
//  DataModel.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-03-04.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

enum RideAdmission: String {
    case general
    case vip
}

enum Area: String {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum Good: String {
    case food
    case mercandise
}

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

protocol ParkAdmissable {
    var key: String { get }
    var admissionAreas: [Area] { get }
    func printSelfToConsole()
}

extension ParkAdmissable {
    var admissionAreas: [Area] {
        var admissionAreas = [Area]()
        admissionAreas.append(.amusement)
        if self is Employee {
            let employee = self as! Employee
            if employee.employeeCard.paymetTerms == .payroll {
                admissionAreas += [.kitchen, .rideControl, .maintenance, .office]
            } else if employee.employeeCard.paymetTerms == .hourly {
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
    
}

protocol Child {
    var birthDate: Date { get }
}

protocol RideAdmissable {
    var rideAdmissionType: RideAdmission { get }
}

extension RideAdmissable {
    var rideAdmissionType: RideAdmission {
        if self is Vip {
            return .vip
        } else {
            return .general
        }
    }
}

protocol Discountable {
    typealias Discount = (value: Int, goodsGroup: Good)
    var discounts: [Discount] { get }
}

extension Discountable {
    var discounts: [Discount] {
        var discounts = [Discount]()
        if self is Vip {
            discounts.append((value: 10, goodsGroup: .food))
            discounts.append((value: 20, goodsGroup: .mercandise))
        } else if self is Employee {
            let employee = self as? Employee
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

protocol Worker {
    typealias EmployeeCard = (paymetTerms: PaymentTerms, department: Department)
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
    func fullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    func fullAddress() -> String {
        return "\(self.streetNumber) \(self.streetName), \(self.city), \(self.state) \(self.zip)"
    }
}

struct Classic: ParkAdmissable, RideAdmissable {
    let key: String = RandomGenerator.randomKey(length: 32)
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
}

struct Vip: ParkAdmissable, RideAdmissable, Discountable {
    let key: String = RandomGenerator.randomKey(length: 32)
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
}

struct FreeChild: ParkAdmissable, Child, RideAdmissable {
    let key: String = RandomGenerator.randomKey(length: 32)
    let birthDate: Date = RandomGenerator.randomDate(daysBack: 5200) ?? Date(timeIntervalSince1970: 0)
    
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
}

struct Employee: ParkAdmissable, Worker, RideAdmissable, Discountable {
    
    let key: String = RandomGenerator.randomKey(length: 32)
    let firstName: String = RandomGenerator.randomElementFrom(file: "firstNames", ofType: "plist")
    let lastName: String = RandomGenerator.randomElementFrom(file: "lastNames", ofType: "plist")
    let streetNumber: Int = Int.random(in: 1000...20000)
    let streetName: String = "\(RandomGenerator.randomElementFrom(file: "streetNames", ofType: "plist")) "
                           + "\(RandomGenerator.randomElementFrom(file: "streetTypes", ofType: "plist"))"
    let city: String = RandomGenerator.randomElementFrom(file: "cities", ofType: "plist")
    let state: String = RandomGenerator.randomElementFrom(file: "states", ofType: "plist")
    let zip: String = String(format: "%05d", Int.random(in: 2801 ... 99950))
    var employeeCard: EmployeeCard = RandomGenerator.randomEmployeeCard()


    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
}



