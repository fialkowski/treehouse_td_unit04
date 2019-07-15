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
        
        passReaders.append(AreaEntryPassReader(ofArea: .amusement))
        passReaders.append(AreaEntryPassReader(ofArea: .kitchen))
        passReaders.append(AreaEntryPassReader(ofArea: .maintenance))
        passReaders.append(AreaEntryPassReader(ofArea: .office))
        passReaders.append(AreaEntryPassReader(ofArea: .rideControl))
        passReaders.append(CashRegisterPassReader(ofStoreType: .food))
        passReaders.append(CashRegisterPassReader(ofStoreType: .mercandise))
        
        for _ in 1...50 {
            let newItem: ParkAdmissable
            do {
                switch Int.random(in: 0...3) {
                    case 0: try newItem = Classic()
                    case 1: try newItem = Vip()
                    case 2: try newItem = FreeChild()
                    default: try newItem = Employee()
                }
            } catch PassInitError.invalidKey {
                print("Wrong Key is entered")
            } catch PassInitError.invalidBirthDate {
                print("Wrong Birth Date is entered")
            } catch PassInitError.invalidCity {
                print("Wrong City Name is entered")
            } catch {
                fatalError("Sorry, something comeletely unexpected has happened")
            }
            entrants.append(newItem)
        }
        
        for index in 0...entrants.count - 1 { //Value type - using index reference
            for reader in passReaders {
                entrants[index].swipe(reader: reader)
                entrants[index].swipe(reader: reader)
            }
        }
        
    }


}

