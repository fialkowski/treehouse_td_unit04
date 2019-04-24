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
            switch Int.random(in: 0...3) {
            case 0: newItem = Classic()
            case 1: newItem = Vip()
            case 2: newItem = FreeChild()
            default: newItem = Employee()
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

