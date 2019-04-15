//
//  AreaEntryPassReader.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//

struct AreaEntryPassReader: PassReader, AreaAssignable {
    let key: String
    let areaType: Area
    
    init(ofArea area: Area = Area.allCases.randomElement()!) {
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
        self.areaType = area
    }
    
    func swipe(pass: ParkAdmissable) {
        self.printSelfToConsole()
        pass.printSelfToConsole()
        if pass.admissionAreas.contains(self.areaType) {
            ConsolePrinter.printAreaSwipeResult(pass, hasAccess: true)
        } else {
            ConsolePrinter.printAreaSwipeResult(pass, hasAccess: false)
        }
    }
    
    func printSelfToConsole() {
        var outputString = "🔒This is \(areaType.rawValue) area card reader, with key \(key)\n"
            outputString += "Scanning pass ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️"
        print(outputString)
    }
}

struct CashRegisterPassReader: PassReader, CashRegisterAssignable {
    var key: String
    var storeType: Good
    
    init(ofStoreType storeType: Good = Good.allCases.randomElement()!) {
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
        self.storeType = storeType
    }
    
    func swipe(pass: ParkAdmissable) {
        self.printSelfToConsole()
        pass.printSelfToConsole()
        if let discountablePass = pass as? Discountable {
            ConsolePrinter.printCashRegisterSwipeResult(discountablePass)
        }
    }
    
    func printSelfToConsole() {
        var outputString = "💳 This is \(storeType.rawValue) store register card reader, with key \(key)\n"
        outputString += "Scanning pass ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️"
        print(outputString)
    }

}
