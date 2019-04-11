//
//  AreaEntryPassReader.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//

struct AreaEntryPassReader: PassReadable {
    let key: String
    let areaType: Area
    
    init(ofArea area: Area) {
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
        self.areaType = area//.amusement//Area.allCases.randomElement()! // Forceunwrapping since the enum is for sure not empty
    }
    
    func swipe(pass: ParkAdmissable) {
        self.printSelfToConsole()
        pass.printSelfToConsole()
        if pass.admissionAreas.contains(self.areaType) {
            ConsolePrinter.printSwipeResult(pass, hasAccess: true)
        } else {
            ConsolePrinter.printSwipeResult(pass, hasAccess: false)
        }
    }
    
    func printSelfToConsole() {
        var outputString = "🔒This is \(areaType.rawValue) area card reader, with key \(key)\n"
            outputString += "Scanning pass ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️"
        print(outputString)
    }
}
