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
    func enable () {
        self.isEnabled = true
    }
    func disable () {
        self.isEnabled = false
    }
}

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
 
    }
    
    var mainMenuHandler: MainMenuHandler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topMenuBarStackView.setBackground(to: .topMenuBarColor)
        subMenuBarStackView.setBackground(to: .subMenuBarColor)

        
        do {
            mainMenuHandler = try MainMenuHandler(topStackView: topMenuBarStackView, bottomStackView: subMenuBarStackView, source: MainMenuInterpreter.retrieve(from: FileReader.read(from: "mainMenu", ofType: "plist")))
            //let mainMenuHandler = try MainMenuHandler(topStackView: topMenuBarStackView, bottomStackView: subMenuBarStackView, source: MainMenuRetriever(from: "mainMenu", ofType: "plist"))
        } catch MainMenuRetriverError.invalidMainMenuFileNameOrType {
            AlertController.showFatalError(for: MainMenuRetriverError.invalidMainMenuFileNameOrType)
        } catch MainMenuRetriverError.corruptMainMenuFileOrWrongFormat {
            AlertController.showFatalError(for: MainMenuRetriverError.corruptMainMenuFileOrWrongFormat)
        } catch let error {
            AlertController.showFatalError(for: error)
        }
        print(mainMenuHandler?.source ?? "GFU")


        
        let button = UIButton(type: .system)
        button.setTitle("Click here", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        topMenuBarStackView.insertArrangedSubview(button, at: 0)
        //TODO: A new menu concept will be creating a struct that will create and add all of the required buttons for us and add them to the stack views. I'm thinking of making it a class that manages the entire menu, where all of the menus and sub menues are dictionaries! DO DICTIONARY NOT ENUM!!!!
        
        
        //menuButtonHandler.deactivate(.topMenu)
        //menuButtonHandler.deactivate(.subMenu)
//        var entrants = [ParkAdmissable]()
//        var passReaders = [PassReader]()
//        do {
//        try passReaders.append(AreaEntryPassReader(ofArea: .amusement))
//        try passReaders.append(AreaEntryPassReader(ofArea: .kitchen))
//        try passReaders.append(AreaEntryPassReader(ofArea: .maintenance))
//        try passReaders.append(AreaEntryPassReader(ofArea: .office))
//        try passReaders.append(AreaEntryPassReader(ofArea: .rideControl))
//        try passReaders.append(CashRegisterPassReader(ofStoreType: .food))
//        try passReaders.append(CashRegisterPassReader(ofStoreType: .mercandise))
//        } catch PassReaderInitError.invalidKey(let description) {
//            print(description)
//        } catch let error {
//            print(error)
//        }
//        for _ in 1...50 {
//            let newItem: ParkAdmissable
//                switch Int.random(in: 0...3) {
//                case 0: do {
//                            try newItem = Classic()
//                            entrants.append(newItem)
//                        } catch PassInitError.invalidKey(let description) {
//                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch let error {
//                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
//                        }
//
//                case 1: do {
//                            try newItem = Vip()
//                            entrants.append(newItem)
//                        } catch PassInitError.invalidKey(let description) {
//                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch let error {
//                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
//                        }
//
//                case 2: do {
//                            try newItem = FreeChild()
//                            entrants.append(newItem)
//                        } catch PassInitError.invalidKey(let description) {
//                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch PassInitError.invalidBirthDate(let description){
//                            print(description)
//                        } catch let error {
//                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
//                        }
//
//                default: do {
//                            try newItem = Employee()
//                            entrants.append(newItem)
//                        } catch PassInitError.invalidKey(let description) {
//                            print("\n🚨 Wrong Key or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch PassInitError.invalidFirstName(let description) {
//                            print("\n🚨 Wrong First Name or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch PassInitError.invalidLastName(let description) {
//                            print("\n🚨 Wrong Last Name or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch PassInitError.invalidStreetNumber(let description) {
//                            print("\n🚨 Wrong Street Numer or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch PassInitError.invalidStreetName(let description) {
//                            print("\n🚨 Wrong Street Name or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch PassInitError.invalidCity(let description) {
//                            print("\n🚨 Wrong City Name or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch PassInitError.invalidState(let description) {
//                            print("\n🚨 Wrong State Name or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch PassInitError.invalidZip(let description) {
//                            print("\n🚨 Wrong Zip Code or nil value was entered while creating an instance of \(description) 🚨")
//                        } catch let error {
//                            fatalError("Sorry, something comeletely unexpected has happened ->>> \(error)")
//                        }
//                }
//        }
//
//        for index in 0...entrants.count - 1 { //Value type - using index reference
//            for reader in passReaders {
//                entrants[index].swipe(reader: reader)
//                entrants[index].swipe(reader: reader)
//            }
//        }
     }
    

    @objc func buttonClicked(sender : UIButton){
        let alert = UIAlertController(title: "Clicked", message: "You have clicked on the button", preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
    }
}
