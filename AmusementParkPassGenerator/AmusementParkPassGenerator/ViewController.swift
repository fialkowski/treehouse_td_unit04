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
        let testReader = AreaEntryPassReader(ofArea: .amusement)
        
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
        
        for entrant in entrants {
            testReader.swipe(pass: entrant)
        }
    }


}

