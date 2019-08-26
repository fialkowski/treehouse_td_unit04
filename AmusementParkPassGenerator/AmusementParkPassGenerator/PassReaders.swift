//
//  AreaEntryPassReader.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//
import Foundation

enum PassReaderInitError: Error {
    case invalidKey(throwingInstance: String)
}

struct AreaEntryPassReader: PassReader, AreaAssignable {
    let key: String
    let areaType: Area
    
    init(ofArea area: Area = Area.allCases.randomElement()!) throws {
        self.key = RandomGenerator.randomPassKey
        self.areaType = area
    }
    
    func printSelfToConsole() {
        var outputString = "\n🔒This is \(areaType.rawValue) area card reader, with key \(key)\n"
            outputString += "Scanning pass ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️"
        print(outputString)
    }
}

struct CashRegisterPassReader: PassReader, CashRegisterAssignable {
    var key: String
    var storeType: Good
    
    init(ofStoreType storeType: Good = Good.allCases.randomElement()!) throws {
        self.key = RandomGenerator.randomPassKey
        self.storeType = storeType
    }
    
    func printSelfToConsole() {
        var outputString = "\n💳 This is \(storeType.rawValue) store register card reader, with key \(key)\n"
        outputString += "Scanning pass ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️ ⬇️"
        print(outputString)
    }

}
