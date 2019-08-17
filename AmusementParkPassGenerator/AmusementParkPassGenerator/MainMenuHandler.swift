//
//  MainMenuHandler.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-01.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

enum MainMenuHandlerError: Error {
    case noSubmenuMatchingTheTopMenuButton
    case noButtonCaption
    case buttonCaptionDoesNotMatchModelDataType
    case noTopMenuButtonsFound
    case noSubMenuButtonsFound
}

class MainMenuHandler {

    let viewController: MainMenuCompliant
    var menuButtons = [UIButton:[UIButton]]()
    
    

    init (viewController: MainMenuCompliant, source: [String:[String]]) {
        
        self.viewController = viewController
        
        for (key, value) in source {
            let topMenuButton = UIButton(type: .system)
            topMenuButton.setStyle(to: .topMenuInactive)
            topMenuButton.setTitle(key, for: .normal)
            topMenuButton.addTarget(self, action: #selector(topMenuButtonPressed), for: .touchUpInside)
            if value.isEmpty {
                menuButtons.updateValue([], forKey: topMenuButton)
            } else {
                var subMenuButtons = [UIButton]()
                var sortedSubMenu = value
                sortedSubMenu.sort()
                for buttonName in sortedSubMenu {
                    let subMenuButton = UIButton(type: .system)
                    subMenuButton.setStyle(to: .subMenuInactive)
                    subMenuButton.setTitle(buttonName, for: .normal)
                    subMenuButton.addTarget(self, action: #selector(subMenuButtonPressed), for: .touchUpInside)
                    subMenuButtons.append(subMenuButton)
                }
                menuButtons.updateValue(subMenuButtons, forKey: topMenuButton)
            }
        }
    }
    
    func setMainMenu() {
        let sortedMenu = menuButtons.sorted { $0.key.titleLabel!.text! < $1.key.titleLabel!.text! }
        viewController.topMenuBarStackView.isHidden = true
        viewController.subMenuBarStackView.isHidden = true
        viewController.topMenuBarStackView.setBackground(to: .topMenuBarColor)
        viewController.subMenuBarStackView.setBackground(to: .subMenuBarColor)
        
        var stackViewIndex = 0
        for topMenuButton in sortedMenu {
            viewController.topMenuBarStackView.insertArrangedSubview(topMenuButton.key, at: stackViewIndex)
            stackViewIndex += 1
        }
        viewController.topMenuBarStackView.isHidden = false
    }
    
    @objc private func topMenuButtonPressed(sender : UIButton) throws {
        let allTextFields = Mirror(reflecting: viewController).children.compactMap { $0.value as? UITextField }
        if !allTextFields.isEmpty {
            let notEmptyTextFiels = allTextFields.filter { !$0.text!.isEmpty }
            if !notEmptyTextFiels.isEmpty {
                AlertController.showSingleActionAlertWith(title: "Test", message: "Test", style: .alert)
            }
        }
        
        
        viewController.topMenuBarStackView.isHidden = true
        viewController.subMenuBarStackView.isHidden = true
        viewController.passDataInputController?.setDisabledScreen()
        try allSubMenuButtonsDisable()
        guard let topMenuButtons = viewController.topMenuBarStackView.arrangedSubviews as? [UIButton] else {
            throw MainMenuHandlerError.noTopMenuButtonsFound
        }
        topMenuButtons.forEach { $0.setStyle(to: .topMenuInactive)}
        
        sender.setStyle(to: .topMenuActive)
        viewController.subMenuBarStackView.removeAllArrangedSubviews()
        guard let subMenuIndex = menuButtons.index(forKey: sender) else {
            throw MainMenuHandlerError.noSubmenuMatchingTheTopMenuButton
        }
        
        if !menuButtons[subMenuIndex].value.isEmpty {
            var stackViewIndex = 0
            menuButtons[subMenuIndex].value.forEach {
                viewController.subMenuBarStackView.insertArrangedSubview($0, at: stackViewIndex);
                stackViewIndex += 1
            }
            
            viewController.subMenuBarStackView.isHidden = false
        } else {
            guard let senderTitle = sender.titleLabel?.text?.lowercased() else {
                throw MainMenuHandlerError.noButtonCaption
            }
            switch senderTitle {
            case "vendor" : do { viewController.passDataInputController?.setVendorInputScreen() }
            case "manager" : do { viewController.passDataInputController?.setManagerInputScreen() }
            default: throw MainMenuHandlerError.buttonCaptionDoesNotMatchModelDataType
            }
        }
        viewController.topMenuBarStackView.isHidden = false
    }
    
    @objc private func subMenuButtonPressed(sender : UIButton) throws {
        try allSubMenuButtonsDisable()
        sender.setStyle(to: .subMenuActive)
        
        guard let senderTitle = sender.titleLabel?.text?.lowercased() else {
            throw MainMenuHandlerError.noButtonCaption
        }
        switch senderTitle {
        case "contract" : do { viewController.passDataInputController?.setEmployeeInputScreen() }
        case "food services" : do { viewController.passDataInputController?.setEmployeeInputScreen() }
        case "ride services" : do { viewController.passDataInputController?.setEmployeeInputScreen() }
        case "maintenance" : do { viewController.passDataInputController?.setEmployeeInputScreen() }
        case "season pass" : do { viewController.passDataInputController?.setGuestSeasonPassInputScreen() }
        case "vip" : do { viewController.passDataInputController?.setGuestVipInputScreen() }
        case "adult" : do { viewController.passDataInputController?.setGuestAdultInputScreen() }
        case "child" : do { viewController.passDataInputController?.setGuestChildInputScreen() }
        case "senior" : do { viewController.passDataInputController?.setGuestSeniorInputScreen() }
        default: throw MainMenuHandlerError.buttonCaptionDoesNotMatchModelDataType
        }
    }
    
    private func allSubMenuButtonsDisable () throws {
        guard let subMenuButtons = viewController.subMenuBarStackView.arrangedSubviews as? [UIButton] else {
            throw MainMenuHandlerError.noSubMenuButtonsFound
        }
        subMenuButtons.forEach { $0.setStyle(to: .subMenuInactive) }
    }
}
