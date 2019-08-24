//
//  PassDataInputController.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-05.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var nameValidated: String {
        let charSet = CharacterSet(charactersIn: " .\'’abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
        let cleanedString = self.components(separatedBy: charSet).joined(separator: "")
        let components = cleanedString.components(separatedBy: .whitespacesAndNewlines)
        let trimmedString = components.filter { !$0.isEmpty }.joined(separator: " ")
        let trimmedCapitalizedOutput = trimmedString.capitalized
        return trimmedCapitalizedOutput
    }
    
    var ssnValidated: String {
        let charSet = CharacterSet(charactersIn: " -1234567890").inverted
        let strippedString = self.components(separatedBy: charSet).joined(separator: "")
        return String(strippedString.prefix(15))
        
    }
    
    var projectNumberValidated: String {
        let charSet = CharacterSet(charactersIn: "1234567890").inverted
        let strippedString = self.components(separatedBy: charSet).joined(separator: "")
        return String(strippedString.prefix(7))
        
    }
    
    var zipValidated: String {
        let charSet = CharacterSet(charactersIn: "1234567890").inverted
        let strippedString = self.components(separatedBy: charSet).joined(separator: "")
        return String(strippedString.prefix(5))
    }
    
    var strippedNumbers: String {
        return self.filter("01234567890".contains)
    }
    
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
    
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }
}

class PassDataInputController {
    
    private let viewController: PassDataInputCompliant
    private let inputAccessoryViewHandler: InputAccessoryViewHandler
    private let datePicker = UIDatePicker()
    
    
    init (for viewController: PassDataInputCompliant) {
        self.viewController = viewController
        self.datePicker.datePickerMode = .date
        self.datePicker.maximumDate = Date()
        self.inputAccessoryViewHandler = InputAccessoryViewHandler(forViewController: viewController)
    }
    
    func setGuestAdultInputScreen () {
        setDisabledScreen()
        viewController.generateButton.enable()
    }
    
    func setGuestChildInputScreen () {
        setDisabledScreen()
        birthDateFieldsEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func setGuestVipInputScreen () {
        setDisabledScreen()
        viewController.generateButton.enable()
    }
    
    func setGuestSeniorInputScreen () {
        setDisabledScreen()
        birthDateFieldsEnable()
        ssnFieldsEnable()
        firstNameFieldsEnable()
        lastNameFieldsEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func setGuestSeasonPassInputScreen () {
        setDisabledScreen()
        firstNameFieldsEnable()
        lastNameFieldsEnable()
        addressFieldsEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func setEmployeeInputScreen () {
        setDisabledScreen()
        firstNameFieldsEnable()
        lastNameFieldsEnable()
        addressFieldsEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func setManagerInputScreen () {
        setDisabledScreen()
        firstNameFieldsEnable()
        lastNameFieldsEnable()
        addressFieldsEnable()
        viewController.generateButton.enable()
        viewController.populateButton.enable()
    }
    
    func setVendorInputScreen () {
        setDisabledScreen()
        firstNameFieldsEnable()
        lastNameFieldsEnable()
        birthDateFieldsEnable()
        companyFieldsEnable()
        dateOfVisitEnable()
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
    
    #warning("rename methods to something like ssnInputEnable")
    
    private func controlButtonsDisable () {
        viewController.generateButton.setStyle(to: .generate)
        viewController.generateButton.disable()
        viewController.populateButton.setStyle(to: .populate)
        viewController.populateButton.disable()
    }
    
    private func birthDateFieldsEnable () {
        viewController.birthDateField.enable()
        viewController.birthDateLabel.enable()
        viewController.birthDateField.addTarget(self, action: #selector(setDateInput), for: .editingDidBegin)
    }
    
    
    private func ssnFieldsEnable () {
        viewController.ssnLabel.enable()
        viewController.ssnField.enable()
        viewController.ssnField.keyboardType = .numberPad
        viewController.ssnField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
        viewController.ssnField.addTarget(self, action: #selector(ssnFormat), for: .editingChanged)
    }
    
    private func firstNameFieldsEnable () {
        viewController.firstNameLabel.enable()
        viewController.firstNameField.enable()
        viewController.firstNameField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
        viewController.firstNameField.addTarget(self, action: #selector(defaultTextFieldValidation), for: .editingChanged)
    }
    
    private func lastNameFieldsEnable () {
        viewController.lastNameLabel.enable()
        viewController.lastNameField.enable()
        viewController.lastNameField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
    }
    
    private func companyFieldsEnable () {
        viewController.companyLabel.enable()
        viewController.companyField.enable()
        viewController.companyField.addTarget(self, action: #selector(setTextInput), for: .editingDidBegin)
    }
    
    private func dateOfVisitEnable () {
        viewController.dateOfVisitLabel.enable()
        viewController.dateOfVisitField.enable()
        viewController.dateOfVisitField.inputView = datePicker
        viewController.dateOfVisitField.addTarget(self, action: #selector(setDateInput), for: .editingDidBegin)
    }
    
    private func addressFieldsEnable () {
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
    
    #warning("Finish this one and the rest of the input validation off!")
    @objc private func ssnFormat (sender: UITextField) {
        if let input = sender.text {
            var validatedInput = input.ssnValidated
            
            if validatedInput.strippedNumbers.count == 4 &&
                validatedInput.firstIndex(of: "-") == nil {
                
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 3))
                validatedInput.insert("-", at: validatedInput.index(validatedInput.startIndex, offsetBy: 4))
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 5))
                
            } else if validatedInput.strippedNumbers.count == 6 &&
                validatedInput.firstIndex(of: "-") == validatedInput.lastIndex(of: "-") {
                
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 8))
                validatedInput.insert("-", at: validatedInput.index(validatedInput.startIndex, offsetBy: 9))
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 10))
                
            } else if validatedInput.strippedNumbers.count > 3 &&
                validatedInput.strippedNumbers.count < 7 &&
                validatedInput.firstIndex(of: "-") == nil {
                
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 3))
                validatedInput.insert("-", at: validatedInput.index(validatedInput.startIndex, offsetBy: 4))
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 5))
                
            } else if validatedInput.strippedNumbers.count > 3 &&
                validatedInput.strippedNumbers.count < 7 &&
                validatedInput.firstIndex(of: "-") == nil {
                
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 3))
                validatedInput.insert("-", at: validatedInput.index(validatedInput.startIndex, offsetBy: 4))
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 5))
                
            }
            sender.text = validatedInput
        }
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
    
    
    
    //Checking the data Integrity of the input Screen before creating the instances
    
    @objc private func createAdultGuestPass (sender: UIButton) {}
    
    private func checkAdultGuestPassDataIntegrity () throws -> Void {
        
    }
    
    @objc private func createChildGuestPass (sender: UIButton) {}
    
    @objc private func createVipGuestPass (sender: UIButton) {}
    
    @objc private func createSeasonGuestPass (sender: UIButton) {}
    
    @objc private func createSeniorGuestPass (sender: UIButton) {}
    
    @objc private func contractEmployeePass (sender: UIButton) {}
    
    @objc private func foodServicesEmployeePass (sender: UIButton) {}
    
    @objc private func rideServicesEmployeePass (sender: UIButton) {}
    
    @objc private func maintenanceEmployeePass (sender: UIButton) {}
    
    @objc private func vendorPass (sender: UIButton) {}
    
    @objc private func managerPass (sender: UIButton) {}
}
