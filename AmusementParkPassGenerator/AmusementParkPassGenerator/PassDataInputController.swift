//
//  PassDataInputController.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-05.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

class PassDataInputController {
    
    private let viewController: PassDataInputCompliant
    private let inputAccessoryViewHandler: InputAccessoryViewHandler
    private let datePicker = UIDatePicker()
    lazy var passes = [PassCoreData]()
    
    
    init (for viewController: PassDataInputCompliant) {
        self.viewController = viewController
        self.datePicker.datePickerMode = .date
        self.datePicker.maximumDate = Date()
        self.inputAccessoryViewHandler = InputAccessoryViewHandler(forViewController: viewController)
    }
    
    func adultGuestPassInputEnable () {
        setDisabledScreen()
        viewController.generateButton.enable()
        viewController.generateButton.addTarget(self, action: #selector(createAdultGuestPass), for: .touchUpInside)
    }
    
    func childGuestPassInputEnable () {
        setDisabledScreen()
        birthDateInputEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
        viewController.generateButton.addTarget(self, action: #selector(createChildGuestPass), for: .touchUpInside)
    }
    
    func vipGuestPassInputEnable () {
        setDisabledScreen()
        viewController.generateButton.enable()
        viewController.generateButton.addTarget(self, action: #selector(createVipGuestPass), for: .touchUpInside)
    }
    
    func seniorGuestPassInputEnable () {
        setDisabledScreen()
        birthDateInputEnable()
        ssnInputEnable()
        firstNameInputEnable()
        lastNameInputEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func seasonGuestPassInputEnable () {
        setDisabledScreen()
        firstNameInputEnable()
        lastNameInputEnable()
        addressInputEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func hourlyEmployeePassInputEnable () {
        setDisabledScreen()
        firstNameInputEnable()
        lastNameInputEnable()
        addressInputEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func managerPassInputEnable () {
        setDisabledScreen()
        firstNameInputEnable()
        lastNameInputEnable()
        addressInputEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func vendorPassInputEnable () {
        setDisabledScreen()
        firstNameInputEnable()
        lastNameInputEnable()
        birthDateInputEnable()
        companyInputEnable()
        dateOfVisitInputEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func setDisabledScreen () {
        setTags()
        allInputFieldsDisable()
        controlButtonsDisable()
        allLabelsDisable()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    private func setTags () {
        viewController.birthDateField.tag = 0
        viewController.birthDateLabel.tag = 0
        
        viewController.ssnField.tag = 1
        viewController.ssnLabel.tag = 1
        
        viewController.projectNumberField.tag = 2
        viewController.projectNumberLabel.tag = 2
        
        viewController.firstNameField.tag = 3
        viewController.firstNameLabel.tag = 3
        
        viewController.lastNameField.tag = 4
        viewController.lastNameLabel.tag = 4
        
        viewController.companyField.tag = 5
        viewController.companyLabel.tag = 5
        
        viewController.dateOfVisitField.tag = 6
        viewController.dateOfVisitLabel.tag = 6
        
        viewController.streetAddressField.tag = 7
        viewController.streetAddressLabel.tag = 7
        
        viewController.cityField.tag = 8
        viewController.cityLabel.tag = 8
        
        viewController.stateField.tag = 9
        viewController.stateLabel.tag = 9
        
        viewController.zipCodeField.tag = 10
        viewController.zipCodeLabel.tag = 10
    }
    
    private func allInputFieldsDisable () {
        let allTextFields = Mirror(reflecting: viewController).children.compactMap { $0.value as? UITextField }
        allTextFields.forEach { $0.disable() }
        allTextFields.forEach { $0.text = "" }
    }
    
    private func allLabelsDisable () {
        let allLabels = Mirror(reflecting: viewController).children.compactMap { $0.value as? UILabel }
        allLabels.forEach { $0.disable() }
    }
    
    private func controlButtonsDisable () {
        viewController.generateButton.setStyle(to: .generate)
        viewController.generateButton.disable()
        viewController.populateButton.setStyle(to: .populate)
        viewController.populateButton.disable()
    }
    
    private func birthDateInputEnable () {
        viewController.birthDateField.enable()
        viewController.birthDateLabel.enable()
        viewController.birthDateField.addTarget(self, action: #selector(setDateInput), for: .editingDidBegin)
    }
    
    
    private func ssnInputEnable () {
        viewController.ssnLabel.enable()
        viewController.ssnField.enable()
        viewController.ssnField.keyboardType = .numberPad
        viewController.ssnField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
        viewController.ssnField.addTarget(self, action: #selector(ssnFormat), for: .editingChanged)
    }
    
    private func firstNameInputEnable () {
        viewController.firstNameLabel.enable()
        viewController.firstNameField.enable()
        viewController.firstNameField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
        viewController.firstNameField.addTarget(self, action: #selector(defaultTextFieldValidation), for: .editingChanged)
    }
    
    private func lastNameInputEnable () {
        viewController.lastNameLabel.enable()
        viewController.lastNameField.enable()
        viewController.lastNameField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
    }
    
    private func companyInputEnable () {
        viewController.companyLabel.enable()
        viewController.companyField.enable()
        viewController.companyField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
    }
    
    private func dateOfVisitInputEnable () {
        viewController.dateOfVisitLabel.enable()
        viewController.dateOfVisitField.enable()
        viewController.dateOfVisitField.inputView = datePicker
        viewController.dateOfVisitField.addTarget(self, action: #selector(setDateInput), for: .editingDidBegin)
    }
    
    private func addressInputEnable () {
        viewController.streetAddressLabel.enable()
        viewController.streetAddressField.enable()
        viewController.streetAddressField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
        
        viewController.cityLabel.enable()
        viewController.cityField.enable()
        viewController.cityField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
  
        viewController.stateLabel.enable()
        viewController.stateField.enable()
        viewController.stateField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)

        viewController.zipCodeLabel.enable()
        viewController.zipCodeField.enable()
        viewController.zipCodeField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
    }
    
    
    @objc private func defaultTextFieldValidation (sender: UITextField) {
        sender.text = sender.text?.nameValidated
    }
    
    @objc private func datePickerValueChanged (sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "MM / dd / yyyy"
        viewController.birthDateField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc private func ssnFormat (sender: UITextField) {
        InputDataValidator.ssnFormatter(for: sender)
    }
    
    @objc private func setTextInput (sender: UITextField) {
        let allLabels = Mirror(reflecting: viewController).children.compactMap { $0.value as? UILabel }
        let accessoryViewLabels = allLabels.filter { $0.tag == sender.tag }
        if accessoryViewLabels.isEmpty {
            inputAccessoryViewHandler.setAccessoryViewTargetTo(sender)
        } else {
            if let accessoryViewLabel = accessoryViewLabels.first {
                inputAccessoryViewHandler.setAccessoryViewTargetTo(sender, withLabel: accessoryViewLabel)
            } else {
                inputAccessoryViewHandler.setAccessoryViewTargetTo(sender)
            }
        }
        sender.inputAccessoryView = inputAccessoryViewHandler.accessoryView
    }
    
    @objc private func setDateInput (sender: UITextField) {
        let allLabels = Mirror(reflecting: viewController).children.compactMap { $0.value as? UILabel }
        let accessoryViewLabels = allLabels.filter { $0.tag == sender.tag }
        if accessoryViewLabels.isEmpty {
            inputAccessoryViewHandler.setAccessoryViewTargetTo(sender)
        } else {
            if let accessoryViewLabel = accessoryViewLabels.first {
                inputAccessoryViewHandler.setAccessoryViewTargetTo(sender, withLabel: accessoryViewLabel)
            } else {
                inputAccessoryViewHandler.setAccessoryViewTargetTo(sender)
            }
        }
        sender.inputView = datePicker
        sender.inputAccessoryView = inputAccessoryViewHandler.accessoryView
    }
    
    
    //TODO: Finish the Input process validation and make sure you activate the right things for the correspondind pass input properties, you should look for the passInput screen activation methods above!/
    
    //Checking the data Integrity of the input Screen before creating the instances
    
    @objc private func createAdultGuestPass (sender: UIButton) { // No validation is required here
        passes.append(AdultGuestPass(admissionAreas: [.amusement], rideAccessOrder: .general))
    }

    
    //MARK: Child Guest Pass validation & initializing
    @objc private func createChildGuestPass (sender: UIButton) {
        do {
            try checkChildGuestPassDataIntegrity()
        } catch ChildGuestPassError.emptyDateField {
            AlertController.showSingleActionAlertWith(title: "Oops, something went wrong here", message: "The \"Date Of Birth\" field in empty")
        } catch ChildGuestPassError.invalidDateFormat {
            AlertController.showSingleActionAlertWith(title: "Oops, something went wrong here", message: "The \"Date Of Birth\" has a wrong format!")
        } catch let error {
            fatalError("Holy Molly! That's an unhanled exception \(error)")
        }
    }
    
    enum ChildGuestPassError: Error {
        case emptyDateField, invalidDateFormat
    }
    
    private func checkChildGuestPassDataIntegrity () throws -> Void {
        guard let birthDateText = viewController.birthDateField.text else {
            throw ChildGuestPassError.emptyDateField
        }
        if birthDateText == "" {
            throw ChildGuestPassError.emptyDateField
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM / dd / yyyy"
        
        guard let birthDate = dateFormatter.date(from: birthDateText) else {
            throw ChildGuestPassError.invalidDateFormat
        }
        passes.append(ChildGuestPass(admissionAreas: [.amusement], birthDate: birthDate, rideAccessOrder: .general))
    }
    
    @objc private func createVipGuestPass (sender: UIButton) { // No validation is required here
        passes.append(VipGuestPass(admissionAreas: [.amusement],
                                   discounts: [
                                            VipGuestPass.Discount(discout: 0.1, itemGroup: ItemGroup.food),
                                            VipGuestPass.Discount(discout: 0.2, itemGroup: ItemGroup.merchandise)
                                                              ],
                                   rideAccessOrder: .skipsLine)
                     )
        print(passes)
    }
    
    @objc private func createSeasonGuestPass (sender: UIButton) {}
    
    @objc private func createSeniorGuestPass (sender: UIButton) {}
    
    @objc private func contractEmployeePass (sender: UIButton) {}
    
    @objc private func foodServicesEmployeePass (sender: UIButton) {}
    
    @objc private func rideServicesEmployeePass (sender: UIButton) {}
    
    @objc private func maintenanceEmployeePass (sender: UIButton) {}
    
    @objc private func vendorPass (sender: UIButton) {}
    
    @objc private func managerPass (sender: UIButton) {}
}
