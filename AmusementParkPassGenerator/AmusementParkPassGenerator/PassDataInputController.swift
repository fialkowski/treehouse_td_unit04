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
    
    let viewController: PassDataInputCompliant
    let inputAccessoryViewHandler: InputAccessoryViewHandler
    let datePicker = UIDatePicker()
    //lazy var accessoryView = UIView()
    
    
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
        allInputFieldsDisable()
        controlButtonsDisable()
        allLabelsDisable()
    }
    
    private func allInputFieldsDisable () {
        let allTextFields = Mirror(reflecting: viewController).children.compactMap { $0.value as? UITextField }
        allTextFields.forEach { $0.disable() }
        viewController.birthDateField.tag = 0
        viewController.ssnField.tag = 1
        viewController.projectNumberField.tag = 2
        viewController.firstNameField.tag = 3
        viewController.lastNameField.tag = 4
        viewController.companyField.tag = 5
        viewController.dateOfVisitField.tag = 6
        viewController.streetAddressField.tag = 7
        viewController.cityField.tag = 8
        viewController.stateField.tag = 9
        viewController.zipCodeField.tag = 10
    }
    
    private func controlButtonsDisable () {
        viewController.generateButton.setStyle(to: .generate)
        viewController.generateButton.disable()
        viewController.populateButton.setStyle(to: .populate)
        viewController.populateButton.disable()
    }
    
    private func allLabelsDisable () {
        let allLabels = Mirror(reflecting: viewController).children.compactMap { $0.value as? UILabel }
        allLabels.forEach { $0.disable() }
    }
    
    private func birthDateFieldsEnable () {
        viewController.birthDateField.enable()
        viewController.birthDateLabel.enable()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        viewController.birthDateField.inputView = self.datePicker
        viewController.birthDateField.inputAccessoryView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.birthDateField, withLabel: viewController.birthDateLabel)
    }
    
    private func firstNameFieldsEnable () {
        viewController.firstNameLabel.enable()
        viewController.firstNameField.enable()
        viewController.firstNameField.inputAccessoryView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.firstNameField, withLabel: viewController.firstNameLabel)
    }
    
    private func lastNameFieldsEnable () {
        viewController.lastNameLabel.enable()
        viewController.lastNameField.enable()
        viewController.lastNameField.inputAccessoryView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.lastNameField, withLabel: viewController.lastNameLabel)
    }
    
    private func companyFieldsEnable () {
        viewController.companyLabel.enable()
        viewController.companyField.enable()
        viewController.companyField.inputAccessoryView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.companyField, withLabel: viewController.companyLabel)
    }
    
    private func dateOfVisitEnable () {
        viewController.dateOfVisitLabel.enable()
        viewController.dateOfVisitField.enable()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        viewController.dateOfVisitField.inputView = datePicker
        viewController.dateOfVisitField.inputAccessoryView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.dateOfVisitField, withLabel: viewController.dateOfVisitLabel)
    }
    
    private func addressFieldsEnable () {
        viewController.streetAddressLabel.enable()
        viewController.streetAddressField.enable()
        viewController.streetAddressField.inputView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.streetAddressField, withLabel: viewController.streetAddressLabel)
        viewController.cityLabel.enable()
        viewController.cityField.enable()
        viewController.cityField.inputView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.cityField, withLabel: viewController.cityLabel)
        viewController.stateLabel.enable()
        viewController.stateField.enable()
        viewController.stateField.inputView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.stateField, withLabel: viewController.stateLabel)
        viewController.zipCodeLabel.enable()
        viewController.zipCodeField.enable()
        viewController.zipCodeField.inputView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.zipCodeField, withLabel: viewController.zipCodeLabel)
    }
    
    @objc func datePickerValueChanged (sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "MM / dd / yyyy"
        viewController.birthDateField.text = dateFormatter.string(from: sender.date)
    }
}
