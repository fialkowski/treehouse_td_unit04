//
//  Employee.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-04-10.
//  Copyright © 2019 nikko444. All rights reserved.
//

struct Employee: ParkAdmissable, Worker, RideAdmissable, Discountable {
    let key: String
    let firstName: String
    let lastName: String
    let streetNumber: Int
    let streetName: String
    let city: String
    let state: String
    let zip: String
    var employeeCard: EmployeeCard
    
    func printSelfToConsole() {
        ConsolePrinter.printPass(self)
    }
    
    init() {
        self.key = RandomGenerator.randomKey(length: 32) // Generates a random key for the instance
        self.firstName = RandomGenerator.randomElementFrom(file: "firstNames", ofType: "plist") //Grabs a random string from the plist as a first name
        self.lastName = RandomGenerator.randomElementFrom(file: "lastNames", ofType: "plist") //Grabs a random string from the plist as a last name
        self.streetNumber = Int.random(in: 1000...20000) //Generates a random integer within a given range
        self.streetName = "\(RandomGenerator.randomElementFrom(file: "streetNames", ofType: "plist")) " //Grabs a random string from the plist as a street name
            + "\(RandomGenerator.randomElementFrom(file: "streetTypes", ofType: "plist"))" //Grabs a random string from the plist as a street type
        self.city = RandomGenerator.randomElementFrom(file: "cities", ofType: "plist") //Grabs a random string from the plist as a city
        self.state = RandomGenerator.randomElementFrom(file: "states", ofType: "plist") //Grabs a random string from the plist as a state
        self.zip = String(format: "%05d", Int.random(in: 2801 ... 99950)) //Generates a random integer within a given range and format
        self.employeeCard = RandomGenerator.randomEmployeeCard() //Generates a random employye card
    }
}
