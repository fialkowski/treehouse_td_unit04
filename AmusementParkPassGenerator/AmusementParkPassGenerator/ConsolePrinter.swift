//
//  ConsolePrinter.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-14.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation

class ConsolePrinter {
    static func printPass (_ pass: ParkAdmissable) {
        
        var outputString = String()
        var admissionAreasString = String()
        var discountsString = String()
        var loopCounter: Int = 0
        
        switch pass {
        case is Vip: do {
            let vip = pass as! Vip //Forceunwrapped since checked with switch statement condition
            for admissionArea in vip.admissionAreas {
                loopCounter += 1
                admissionAreasString += "\(admissionArea.rawValue)"
                if loopCounter != vip.admissionAreas.count {
                    admissionAreasString += "; "
                }
            }
            loopCounter = 0
            for discount in vip.discounts {
                loopCounter += 1
                discountsString += "\(discount.value)% for \(discount.goodsGroup.rawValue)"
                if loopCounter != vip.discounts.count {
                    discountsString += "; "
                }
            }
            outputString += "\n➡️ This is VIP Guest Pass 🎩🧐\n"
            outputString += "Pass key: \(vip.key)\n"
            outputString += "Ride admission: \(vip.rideAdmissionType.rawValue)\n"
            outputString += "Admission areas: \(admissionAreasString)\n"
            outputString += "Eligible for discounts: \(discountsString)"
            }
        case is FreeChild: do {
            var birthDateString = String()
            let freeChild = pass as! FreeChild
            for admissionArea in freeChild.admissionAreas {
                loopCounter += 1
                admissionAreasString += "\(admissionArea.rawValue)"
                if loopCounter != freeChild.admissionAreas.count {
                    admissionAreasString += "; "
                }
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "en_US")
            birthDateString = dateFormatter.string(from: freeChild.birthDate) // Jan 2, 2001
            
            outputString += "\n➡️ This is Free Child Guest Pass 🦄🌈😊\n"
            outputString += "Pass key: \(freeChild.key)\n"
            outputString += "Birth date: \(birthDateString)\n"
            outputString += "Ride admission: \(freeChild.rideAdmissionType.rawValue)\n"
            outputString += "Admission areas: \(admissionAreasString)"
            }
        case is Employee: do {
            let employee = pass as! Employee //Forceunwrapped since checked with switch statement condition
            var emojiString = String()
            var headerString = String()
            for admissionArea in employee.admissionAreas {
                loopCounter += 1
                admissionAreasString += "\(admissionArea.rawValue)"
                if loopCounter != employee.admissionAreas.count {
                    admissionAreasString += ", "
                }
            }
            
            switch employee.employeeCard.paymetTerms {
            case .hourly:
                headerString += "Hourly"
                emojiString += "⏱"
            case .payroll:
                headerString += "Payroll"
                emojiString += "👔"
            }
            headerString += " Employee ("
            switch employee.employeeCard.department {
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
                headerString += "Office"
                emojiString += "🗄📈"
            }
            outputString += "\n➡️ This is \(headerString)) Pass \(emojiString)\n"
            outputString += "Pass key: \(employee.key)\n"
            outputString += "Full Name: \(employee.fullName)\n"
            outputString += "Address: \(employee.fullAddress)\n"
            outputString += "Ride admission: \(employee.rideAdmissionType.rawValue)\n"
            outputString += "Admission areas: \(admissionAreasString)"
            }
        case is Classic: do {
            let classic = pass as! Classic //Forceunwrapped since checked with switch statement condition
            for admissionArea in classic.admissionAreas {
                loopCounter += 1
                admissionAreasString += "\(admissionArea.rawValue)"
                if loopCounter != classic.admissionAreas.count {
                    admissionAreasString += "; "
                }
            }
            outputString += "\n➡️ This is Classic Guest Pass 😃\n"
            outputString += "Pass key: \(classic.key)\n"
            outputString += "Ride admission: \(classic.rideAdmissionType.rawValue)\n"
            outputString += "Admission areas: \(admissionAreasString)"
            }
        default: do {
            outputString += "\n🛑 This is Unknown Pass ✋\n"
            outputString += "Pass key: \(pass.key)\n"
            outputString += "🚨 Report to the Office 🚨\n"
            print(outputString)
            }
        }
        print(outputString)
    }
    
    static func printAreaSwipeResult (_ pass: ParkAdmissable, hasAccess: Bool) {
        switch hasAccess {
        case true: do {
            if let child = pass as? FreeChild {
                let calendar = Calendar.current
                if (calendar.component(.month, from: child.birthDate) == calendar.component(.month, from: Date(timeIntervalSinceNow: 0))) &&
                    (calendar.component(.day, from: child.birthDate) == calendar.component(.day, from: Date(timeIntervalSinceNow: 0))) {
                    print("🎉🎉🎉🎈🎈🎈🎉🎉🎉Party Time! It's your BD!🎉🎉🎉🎈🎈🎈🎉🎉🎉")
                }
            }
            print("\n✅ ✅ ✅ ✅ ✅ ✅ ✅ ACCESS ALLOWED ✅ ✅ ✅ ✅ ✅ ✅ ✅\n")
            }
        case false: print("\n🚨 🚨 🚨 🚨 🚨 🚨 🚨 ACCESS DENIED 🚨 🚨 🚨 🚨 🚨 🚨 🚨\n")
        }
    }
    
    // TODO: This should print only the discount matching the goods groop
    
    static func printCashRegisterSwipeResult (_ pass: Discountable) {
        var outputString = String()
        for discount in pass.discounts {
            outputString += "\(discount.goodsGroup.rawValue)"
        }
    }
}
