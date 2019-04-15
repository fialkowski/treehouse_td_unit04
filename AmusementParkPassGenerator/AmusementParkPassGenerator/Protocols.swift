//
//  Protocols.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//
import Foundation

//PASS READER PROTOCOLS  -------------------------------------------------------------------------------

protocol PassReader { // General protocol that we use to define any pass reader. Will be used as Data type.
    var key: String { get }
    func swipe (pass: ParkAdmissable)
    func printSelfToConsole()
}

protocol AreaAssignable {
    var areaType: Area { get }
}

protocol CashRegisterAssignable {
    var storeType: Good { get }
}

//------------------------------------------------------------------------------------------------------



//PASS TYPES DEFINING PROTOCOLS /W EXTENSIONS  ---------------------------------------------------------

// General protocol that we use to define any pass. Will be used as Data type.
protocol ParkAdmissable {
    var key: String { get }
    var admissionAreas: [Area] { get }
    func printSelfToConsole()
}

extension ParkAdmissable { // This extention contains computed array, that always returns the right admission areas for the given pass as per Instruction
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


// Free child pass defining protocol, set as per objective.
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
    var fullName: String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    var fullAddress: String {
        return "\(self.streetNumber) \(self.streetName), \(self.city), \(self.state) \(self.zip)"
    }
}
