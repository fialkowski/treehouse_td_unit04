//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-03-04.
//  Copyright © 2019 nikko444. All rights reserved.
//

import UIKit

extension UIStackView {
    func setBackground(to color: UIColor) {
        let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = color
            return view
        }()
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        self.insertSubview(backgroundView, at: 0)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
}

extension UIColor {
        static var topMenuBarColor: UIColor  { return UIColor(red: 138/255.0, green: 109/255.0, blue: 170/255.0, alpha: 1.0) }
        static var subMenuBarColor: UIColor { return UIColor(red: 61/255.0, green: 55/255.0, blue: 71/255.0, alpha: 1.0) }
        static var menuButtonActive: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
        static var topMenuButtonInactive: UIColor { return UIColor(red: 206/255.0, green: 193/255.0, blue: 222/255.0, alpha: 1.0) }
        static var subMenuButtonInactive: UIColor { return UIColor(red: 131/255.0, green: 124/255.0, blue: 141/255.0, alpha: 1.0) }
        
}

extension UIButton {
    func setCaption (_ caption: ButtonAssignable) {
        self.setTitle(caption.text, for: .normal)
    }
    func enable () {
        self.isEnabled = true
    }
    func disable () {
        self.isEnabled = false
    }
}

struct Menu {
    
    enum Guest: String, CaseIterable, ButtonAssignable {
        case classic = "Classic"
        case child = "Child"
        case vip = "VIP"
        case seasonPass = "Season Pass"
        case senior = "Senior"
        
        var text: String { return self.rawValue }
    }
    
    enum Employee: String, CaseIterable, ButtonAssignable {
        case foodServices = "Food Services"
        case rideServices = "Ride Services"
        case maintenance = "Maintenance"
        case manager = "Manager"
        case contract = "Contract"
        
        var text: String { return self.rawValue }
    }
}

// AN Idea how to add a required button behaviour look below

//enum OnOffSwitch: Togglable {
//    case off, on
//    mutating func toggle() {
//        switch self {
//        case .off:
//            self = .on
//        case .on:
//            self = .off
//        }
//    }
//}
//var lightSwitch = OnOffSwitch.off
//lightSwitch.toggle()
//// lightSwitch is now equal to .on

protocol ButtonAssignable {
    var text: String { get }
}

enum TopMenuCaption: String, CaseIterable, ButtonAssignable {
    case guest = "Guest"
    case employee = "Employee"
    case manager = "Manager"
    case vendor = "Vendor"
    
    var text: String { return self.rawValue }
}

enum GuestSubMenu: String, CaseIterable, ButtonAssignable {
    case classic = "Classic"
    case child = "Child"
    case vip = "VIP"
    
    var text: String { return self.rawValue }
}

enum EmployeeSubMenu: String, CaseIterable, ButtonAssignable {
    case hourly = "Hourly"
    case office = "Office"
    
    var text: String { return self.rawValue }
}

//struct MenuButton<T: UIButton>

class ViewController: UIViewController {

    @IBOutlet weak var topMenuBarStackView: UIStackView!
    @IBOutlet weak var subMenuBarStackView: UIStackView!
    
    @IBOutlet weak var topMenuButton1: UIButton!
    @IBOutlet weak var topMenuButton2: UIButton!
    @IBOutlet weak var topMenuButton3: UIButton!
    @IBOutlet weak var topMenuButton4: UIButton!
    
    @IBOutlet weak var subMenuButton1: UIButton!
    @IBOutlet weak var subMenuButton2: UIButton!
    @IBOutlet weak var subMenuButton3: UIButton!
    @IBOutlet weak var subMenuButton4: UIButton!
    @IBOutlet weak var subMenuButton5: UIButton!
    
    
    @IBAction func topMenuButtonPress(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case TopMenuCaption.guest.rawValue: subMenuButton1.setTitle("1", for: .normal)
        case TopMenuCaption.employee.rawValue: subMenuButton1.setTitle("2", for: .normal)
        case TopMenuCaption.manager.rawValue: subMenuButton1.setTitle("3", for: .normal)
        case TopMenuCaption.vendor.rawValue: subMenuButton1.setTitle("4", for: .normal)
        default: fatalError("Binding error - Button tieleLabel?.text contains a non TopMenuCaption.rawValue string")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuButtonHandler = MenuButtonHandler(topMenuButtons: [
                                                    topMenuButton1,
                                                    topMenuButton2,
                                                    topMenuButton3,
                                                    topMenuButton4]
                                                , subMenuButtons: [
                                                    subMenuButton1,
                                                    subMenuButton2,
                                                    subMenuButton3,
                                                    subMenuButton4,
                                                    subMenuButton5]
//                                                , topCaptions: TopMenuCaption.allCases.map({$0.rawValue})
                                                , topMenuCaptions: TopMenuCaption.allCases
                                                )
        
        topMenuBarStackView.setBackground(to: .topMenuBarColor)
        subMenuBarStackView.setBackground(to: .subMenuBarColor)
        

        
        let button = UIButton(type: .system)
        button.setTitle("Click here", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        topMenuBarStackView.insertArrangedSubview(button, at: 0)
        //TODO: A new menu concept will be creating a struct that will create and add all of the required buttons for us and add them to the stack views. I'm thinking of making it a class that manages the entire menu, where all of the menus and sub menues are dictionaries! DO DICTIONARY NOT ENUM!!!!
        
        
        menuButtonHandler.deactivate(.topMenu)
        menuButtonHandler.deactivate(.subMenu)
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
                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨")
                        } catch let error {
                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
                        }
                
                case 1: do {
                            try newItem = Vip()
                            entrants.append(newItem)
                        } catch PassInitError.invalidKey(let description) {
                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨")
                        } catch let error {
                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
                        }
                    
                case 2: do {
                            try newItem = FreeChild()
                            entrants.append(newItem)
                        } catch PassInitError.invalidKey(let description) {
                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨")
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

    @objc func buttonClicked(sender : UIButton){
        let alert = UIAlertController(title: "Clicked", message: "You have clicked on the button", preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
    }


}

/* AN EXAMPLE OF AN ERROR POP-UPs
 
 @IBAction func purchase() {
 if let currentSelection = currentSelection {
 do {
 try vendingMachine.vend(selection: currentSelection, quantity: Int(quantityStepper.value))
 updateDisplayWith(balance: vendingMachine.amountDeposited, totalPrice: 0.0, itemPrice: 0.0, itemQuantity: 1)
 } catch VendingMachineError.outOfStock {
 showAlertWith(title: "Out of Stock", message: "This item is unavailable. Please make another selection")
 } catch VendingMachineError.insufficientFunds(let required){
 let message = "You need $\(required) to complete the purchase"
 showAlertWith(title: "Insufficient Funds", message: message)
 } catch VendingMachineError.invalidSelection {
 showAlertWith(title: "Invalid Selection", message: "Please make another selection")
 } catch let error {
 fatalError("\(error)")
 }
 
 if let indexPath = collectionView.indexPathsForSelectedItems?.first {
 collectionView.deselectItem(at: indexPath, animated: true)
 updateCell(having: indexPath, selected: false)
 }
 } else {
 //FIXME: Alert user to no selection
 }
 }
 
 */
