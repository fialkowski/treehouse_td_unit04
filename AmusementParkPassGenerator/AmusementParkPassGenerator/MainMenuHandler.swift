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
}

class MainMenuHandler {

    let viewController: FirstPageAssignable
    var menuButtons = [UIButton:[UIButton]]()

    init (viewController: FirstPageAssignable, source: [String:[String]]) {
        self.viewController = viewController
        
        for (key, value) in source {
            let topMenuButton = UIButton(type: .system)
            topMenuButton.setTitleColor(.topMenuButtonInactive, for: .normal)
            topMenuButton.setTitle(key, for: .normal)
            topMenuButton.titleLabel?.font = UIFont.topMenuButtonInactive
            topMenuButton.addTarget(self, action: #selector(topMenuButtonPressed), for: .touchUpInside)
            if value.isEmpty {
                menuButtons.updateValue([], forKey: topMenuButton)
            } else {
                var subMenuButtons = [UIButton]()
                var sortedSubMenu = value
                sortedSubMenu.sort()
                for buttonName in sortedSubMenu {
                    let subMenuButton = UIButton(type: .system)
                    subMenuButton.setTitleColor(.subMenuButtonInactive, for: .normal)
                    subMenuButton.setTitle(buttonName, for: .normal)
                    subMenuButton.titleLabel?.font = UIFont.subMenuButtonInactive
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
    
    @objc func topMenuButtonPressed(sender : UIButton) throws {
        viewController.topMenuBarStackView.isHidden = true
        viewController.subMenuBarStackView.isHidden = true
        viewController.topMenuBarStackView.setButtonsStyleTo(.topMenuButtonInactive, .topMenuButtonInactive)
        
        sender.setTitleColor(.menuButtonActive, for: .normal)
        sender.titleLabel?.font = .topMenuButtonActive
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
                #warning("fix the plug functions")
            case "vendor" : do { print("pressed vendor!") }
            case "manager" : do { print("pressed manager!") }
            default: throw MainMenuHandlerError.buttonCaptionDoesNotMatchModelDataType
            }
        }
        viewController.topMenuBarStackView.isHidden = false
    }
    
    @objc func subMenuButtonPressed(sender : UIButton) throws {
        viewController.subMenuBarStackView.setButtonsStyleTo(.subMenuButtonInactive, .subMenuButtonInactive)
        sender.setTitleColor(.menuButtonActive, for: .normal)
        sender.titleLabel?.font = .subMenuButtonActive
        guard let senderTitle = sender.titleLabel?.text?.lowercased() else {
            throw MainMenuHandlerError.noButtonCaption
        }
        switch senderTitle {
            #warning("fix the plug functions")
        case "contract" : do { print("pressed contract!") }
        case "food services" : do { print("pressed food!") }
        case "ride services" : do { print("pressed serv!") }
        case "maintenance" : do { print("pressed main!") }
        case "season pass" : do { print("pressed pass!") }
        case "vip" : do { print("pressed vip!") }
        case "adult" : do { print("pressed adult!") }
        case "child" : do { print("pressed child!") }
        case "senior" : do { print("pressed senior!") }
        default: throw MainMenuHandlerError.buttonCaptionDoesNotMatchModelDataType
        }
    }
    
}
