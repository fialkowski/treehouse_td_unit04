//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-03-04.
//  Copyright © 2019 nikko444. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var entrants = [ParkAdmissable]()
        var passReaders = [PassReader]()
        do {
        try passReaders.append(AreaEntryPassReader(ofArea: .amusement))
        try passReaders.append(AreaEntryPassReader(ofArea: .kitchen))
        try passReaders.append(AreaEntryPassReader(ofArea: .maintenance))
        try passReaders.append(AreaEntryPassReader(ofArea: .office))
        try passReaders.append(AreaEntryPassReader(ofArea: .rideControl))
        try passReaders.append(CashRegisterPassReader(ofStoreType: .food))
        try passReaders.append(CashRegisterPassReader(ofStoreType: .mercandise))
        } catch PassReaderInitError.invalidKey(let description) {
            print(description)
        } catch let error {
            print(error)
        }
        for _ in 1...50 {
            let newItem: ParkAdmissable
                switch Int.random(in: 0...3) {
                case 0: do {
                            try newItem = Classic()
                            entrants.append(newItem)
                        } catch PassInitError.invalidKey(let description) {
                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨\n")
                        } catch let error {
                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
                        }
                
                case 1: do {
                            try newItem = Vip()
                            entrants.append(newItem)
                        } catch PassInitError.invalidKey(let description) {
                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨\n")
                        } catch let error {
                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
                        }
                    
                case 2: do {
                            try newItem = FreeChild()
                            entrants.append(newItem)
                        } catch PassInitError.invalidKey(let description) {
                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨\n")
                        } catch PassInitError.invalidBirthDate(let description){
                            print(description)
                        } catch let error {
                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
                        }
                    
                default: do {
                            try newItem = Employee()
                            entrants.append(newItem)
                        } catch PassInitError.invalidKey(let description) {
                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨")
                        } catch PassInitError.invalidFirstName(let description) {
                            print("\n🚨 Wrong First Name or nil value was entered while creating an instance of \(description) 🚨")
                        } catch PassInitError.invalidLastName(let description) {
                            print("\n🚨 Wrong Last Name or nil value was entered while creating an instance of \(description) 🚨")
                        } catch PassInitError.invalidStreetNumber(let description) {
                            print("\n🚨 Wrong Street Numer or nil value was entered while creating an instance of \(description) 🚨")
                        } catch PassInitError.invalidStreetName(let description) {
                            print("\n🚨 Wrong Street Name or nil value was entered while creating an instance of \(description) 🚨")
                        } catch PassInitError.invalidCity(let description) {
                            print("\n🚨 Wrong City Name or nil value was entered while creating an instance of \(description) 🚨")
                        } catch PassInitError.invalidState(let description) {
                            print("\n🚨 Wrong State Name or nil value was entered while creating an instance of \(description) 🚨")
                        } catch PassInitError.invalidZip(let description) {
                            print("\n🚨 Wrong Zip Code or nil value was entered while creating an instance of \(description) 🚨")
                        } catch let error {
                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
                        }
                }
        }
        
        for index in 0...entrants.count - 1 { //Value type - using index reference
            for reader in passReaders {
                entrants[index].swipe(reader: reader)
                entrants[index].swipe(reader: reader)
            }
        }
        
    }
}

