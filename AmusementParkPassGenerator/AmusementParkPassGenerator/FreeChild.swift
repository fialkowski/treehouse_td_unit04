//
//  FreeChild.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//
import Foundation

struct FreeChild: ParkAdmissable, Child, RideAdmissable {
    let key: String
    let birthDate: Date
    
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() {
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
        self.birthDate = RandomGenerator.randomDate(daysBack: 5200) ?? Date(timeIntervalSince1970: 0) // Generates a random date within 5200 days back from today
        /* FIXED DATE ASSIGNING BLOCK FOR TESTING
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        self.birthDate = formatter.date(from: "2001/04/11 22:31")!
         */
    }
}
