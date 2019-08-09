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
    lazy var accessoryView = UIView()
    
    
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
        accessoryView = inputAccessoryViewHandler.setAccessoryViewTargetTo(viewController.birthDateField, withLabel: viewController.birthDateLabel)
        viewController.birthDateField.inputAccessoryView = accessoryView
    }
    
    private func firstNameFieldsEnable () {
        viewController.firstNameLabel.enable()
        viewController.firstNameField.enable()
    }
    
    private func lastNameFieldsEnable () {
        viewController.lastNameLabel.enable()
        viewController.lastNameField.enable()
    }
    
    private func companyFieldsEnable () {
        viewController.companyLabel.enable()
        viewController.companyField.enable()
    }
    
    private func dateOfVisitEnable () {
        viewController.dateOfVisitLabel.enable()
        viewController.dateOfVisitField.enable()
    }
    
    private func addressFieldsEnable () {
        viewController.streetAddressLabel.enable()
        viewController.streetAddressField.enable()
        viewController.cityLabel.enable()
        viewController.cityField.enable()
        viewController.stateLabel.enable()
        viewController.stateField.enable()
        viewController.zipCodeLabel.enable()
        viewController.zipCodeField.enable()
    }
    
    @objc func datePickerValueChanged (sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        viewController.birthDateField.text = dateFormatter.string(from: sender.date)
    }
    
//    @objc func dismissInput() {
//        print("wooot-woot-woot!")
//        //viewController.birthDateField.inputView.
//       //viewController.view.endEditing(true)
//        // view.endEditing(true)
//
//    }
}
