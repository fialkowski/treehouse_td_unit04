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

enum PaymentTerms: String {
    case hourly
    case payroll
}

enum Department: String {
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
    var key: String {
        return RandomGenerator.randomKey(length: 32)
    }
    var admissionAreas: [Area] {
        var admissionAreas = [Area]()
        admissionAreas.append(.amusement)
        if self is Employee {
            let employee = self as! Employee
            if employee.employeeType == .payroll {
                admissionAreas += [.kitchen, .rideControl, .maintenance, .office]
            } else if employee.employeeType == .hourly {
                switch employee.department {
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

extension Child {
    var birthDate: Date {
        return RandomGenerator.randomDate(daysBack: 5200) ?? Date(timeIntervalSince1970: 0)
    }
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
            if employee?.employeeType == .hourly {
                discounts.append((value: 15, goodsGroup: .food))
                discounts.append((value: 25, goodsGroup: .mercandise))
            } else if employee?.employeeType == .payroll {
                discounts.append((value: 15, goodsGroup: .food))
                discounts.append((value: 25, goodsGroup: .mercandise))
            }
        }
        return discounts
    }
}

protocol Worker {
    var employeeType: PaymentTerms { get }
    var department: Department { get }
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
    func printSelfToConsole() {
        var outputString = String()
        var admissionAreasString = String()
        var loopCounter: Int = 0
        for admissionArea in admissionAreas {
            loopCounter += 1
            admissionAreasString += "\(admissionArea.rawValue)"
            if loopCounter != admissionAreas.count {
                admissionAreasString += ","
            }
        }
        outputString += "\n➡️ This is Classic Guest Pass 😃\n"
        outputString += "Pass key: \(key)\n"
        outputString += "Ride admission: \(rideAdmissionType.rawValue)\n"
        outputString += "Admission areas: \(admissionAreasString)"
        print(outputString)
    }
}

struct Vip: ParkAdmissable, RideAdmissable, Discountable {
    func printSelfToConsole() {
        var outputString = String()
        var admissionAreasString = String()
        var discountsString = String()
        var loopCounter: Int = 0
        for admissionArea in admissionAreas {
            loopCounter += 1
            admissionAreasString += "\(admissionArea.rawValue)"
            if loopCounter != admissionAreas.count {
                admissionAreasString += "; "
            }
        }
        loopCounter = 0
        for discount in discounts {
            loopCounter += 1
            discountsString += "\(discount.value)% for \(discount.goodsGroup.rawValue)"
            if loopCounter != discounts.count {
                discountsString += "; "
            }
        }
        outputString += "\n➡️ This is VIP Guest Pass 🎩🧐\n"
        outputString += "Pass key: \(key)\n"
        outputString += "Ride admission: \(rideAdmissionType.rawValue)\n"
        outputString += "Admission areas: \(admissionAreasString)\n"
        outputString += "Eligible for discounts: \(discountsString)"
        print(outputString)
    }
}

struct FreeChild: ParkAdmissable, Child, RideAdmissable {
    func printSelfToConsole() {
        var outputString = String()
        var birthDateString = String()
        var admissionAreasString = String()
        var loopCounter: Int = 0
        for admissionArea in admissionAreas {
            loopCounter += 1
            admissionAreasString += "\(admissionArea.rawValue)"
            if loopCounter != admissionAreas.count {
                admissionAreasString += ","
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        birthDateString = dateFormatter.string(from: birthDate) // Jan 2, 2001
        
        outputString += "\n➡️ This is Free Child Guest Pass 🦄🌈😊\n"
        outputString += "Pass key: \(key)\n"
        outputString += "Birth date: \(birthDateString)\n"
        outputString += "Ride admission: \(rideAdmissionType.rawValue)\n"
        outputString += "Admission areas: \(admissionAreasString)"
        print(outputString)
    }
}

struct Employee: ParkAdmissable, Worker, RideAdmissable, Discountable {
    var employeeType: PaymentTerms
    var department: Department
    var firstName: String
    var lastName: String
    var streetNumber: Int
    var streetName: String
    var city: String
    var state: String
    var zip: String
    func printSelfToConsole() {
        var outputString = String()
        var headerString = String()
        var emojiString = String()
        var admissionAreasString = String()
        var loopCounter: Int = 0
        for admissionArea in admissionAreas {
            loopCounter += 1
            admissionAreasString += "\(admissionArea.rawValue)"
            if loopCounter != admissionAreas.count {
                admissionAreasString += ","
            }
        }
        
        switch self.employeeType {
        case .hourly:
            headerString += "Hourly"
            emojiString += "⏱"
        case .payroll:
            headerString += "Payroll"
            emojiString += "👔"
        }
        headerString += " Employee ("
        switch self.department {
        case .foodServices:
            headerString += "Food Services"
            emojiString += "🍕🥤"
        case .rideServices:
            headerString += "Ride Services"
            emojiString += "🎡🛠"
        case .parkMaintenance:
            headerString += "Maintenance"
            emojiString += "🚚🏭"
        case .office:
            headerString += "Ride Services "
            emojiString += "🗄📈"
        }
        outputString += "\n➡️ This is \(headerString)) Pass \(emojiString)\n"
        outputString += "Pass key: \(key)\n"
        outputString += "Ride admission: \(rideAdmissionType.rawValue)\n"
        outputString += "Admission areas: \(admissionAreasString)"
        print(outputString)
    }
}



