//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-03-04.
//  Copyright © 2019 nikko444. All rights reserved.
//

import UIKit

protocol MainMenuCompliant where Self: UIViewController {
    var topMenuBarStackView: UIStackView! { get }
    var subMenuBarStackView: UIStackView! { get }
    var passDataInputController: PassDataInputController? { get }
}

protocol PassDataInputCompliant where Self: UIViewController {
    var birthDateLabel: UILabel! { get }
    var ssnLabel: UILabel! { get }
    var projectNumberLabel: UILabel! { get }
    var firstNameLabel: UILabel! { get }
    var lastNameLabel: UILabel! { get }
    var dateOfVisitLabel: UILabel! { get }
    var companyLabel: UILabel! { get }
    var streetAddressLabel: UILabel! { get }
    var cityLabel: UILabel! { get }
    var stateLabel: UILabel! { get }
    var zipCodeLabel: UILabel! { get }
    
    var birthDateField: UITextField! { get }
    var ssnField: UITextField! { get }
    var projectNumberField: UITextField! { get }
    var firstNameField: UITextField! { get }
    var lastNameField: UITextField! { get }
    var companyField: UITextField! { get }
    var dateOfVisitField: UITextField! { get }
    var streetAddressField: UITextField! { get }
    var cityField: UITextField! { get }
    var stateField: UITextField! { get }
    var zipCodeField: UITextField! { get }
    
    var generateButton: UIButton! { get }
    var populateButton: UIButton! { get }
    
    var mainMenuHandler: MainMenuHandler? { get }
}


class FirstPageViewController: UIViewController, MainMenuCompliant, PassDataInputCompliant  {
    

    @IBOutlet weak var topMenuBarStackView: UIStackView!
    @IBOutlet weak var subMenuBarStackView: UIStackView!
    
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var ssnLabel: UILabel!
    @IBOutlet weak var projectNumberLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var dateOfVisitLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    @IBOutlet weak var birthDateField: UITextField!
    @IBOutlet weak var ssnField: UITextField!
    @IBOutlet weak var projectNumberField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var dateOfVisitField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var populateButton: UIButton!
    
    var mainMenuHandler: MainMenuHandler?
    var passDataInputController: PassDataInputController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passDataInputController = PassDataInputController(for: self)
        
        do {
            mainMenuHandler = try MainMenuHandler(viewController: self,
                                                  source: MainMenuInterpreter.retrieve(from:
                                                    FileReader.read(from: "mainMenu", ofType: "plist")))
            
        } catch MainMenuRetriverError.invalidMainMenuFileNameOrType {
            AlertController.showFatalError(for: MainMenuRetriverError.invalidMainMenuFileNameOrType)
        } catch MainMenuRetriverError.corruptMainMenuFileOrWrongFormat {
            AlertController.showFatalError(for: MainMenuRetriverError.corruptMainMenuFileOrWrongFormat)
        } catch let error {
            AlertController.showFatalError(for: error)
        }
        mainMenuHandler?.setMainMenu()
        passDataInputController?.setDisabledScreen()
    }
}
