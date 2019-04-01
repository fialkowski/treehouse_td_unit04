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
        let classicGuest = Classic()
        let freeChild = FreeChild()
        let vipGuest = Vip()
        let employee = Employee(employeeType: .hourly, department: .foodServices)
        classicGuest.printSelfToConsole()
        vipGuest.printSelfToConsole()
        freeChild.printSelfToConsole()
        employee.printSelfToConsole()
    }


}

