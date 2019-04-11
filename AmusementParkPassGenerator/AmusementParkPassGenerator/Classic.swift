//
//  Classic.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//

struct Classic: ParkAdmissable, RideAdmissable {
    let key: String
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() {
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
    }
}
