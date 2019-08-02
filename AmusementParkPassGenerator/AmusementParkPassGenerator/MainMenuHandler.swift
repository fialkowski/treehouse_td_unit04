//
//  MainMenuHandler.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-01.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary where Dictionary.Key == UIButton {
    func sortByButtonName () {
        
    }
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
            topMenuButton.addTarget(self, action: #selector(topMenuButtonClicked), for: .touchUpInside)
            if value.isEmpty {
                menuButtons.updateValue([], forKey: topMenuButton)
            } else {
                var subMenuButtons = [UIButton]()
                var sortedSubMenu = value
                sortedSubMenu.sort()
                for buttonName in sortedSubMenu {
                    let subMenuButton = UIButton(type: .system)
                    subMenuButton.tintColor = .white
                    subMenuButton.setTitle(buttonName, for: .normal)
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
        viewController.topMenuBarStackView.showAnimated(in: viewController.topMenuBarStackView)
    }
    
    #warning("Make it a class extension!!!")
    func resetButtons (in stackView: UIStackView) {
        guard let buttonArray = stackView.arrangedSubviews as? [UIButton] else {
            return
        }
        for button in buttonArray { button.titleLabel?.font = .topMenuButtonInactive }
    }
    
    @objc func topMenuButtonClicked(sender : UIButton){
        viewController.topMenuBarStackView.isHidden = true
        viewController.subMenuBarStackView.isHidden = true
        resetButtons(in: viewController.topMenuBarStackView)
//        numbers.map() { number -> Int in
//            if number % 2  == 0 {
//                return number/2
//            } else {
//                return number/3
//            }
//        }
        
        sender.setTitleColor(.menuButtonActive, for: .normal)
        sender.titleLabel?.font = .topMenuButtonActive
        viewController.subMenuBarStackView.removeAllArrangedSubviews()
        guard let subMenuIndex = menuButtons.index(forKey: sender) else {
            #warning("Got to throw from here!")
            return
        }

        //AlertController.showAlertWith(title: "Test Pop-Up!", message: "Submenu is \(String(describing: menuButtons[subMenuIndex].value))", style: .alert)
        
        if !menuButtons[subMenuIndex].value.isEmpty {
            var stackViewIndex = 0
            for subMenuButton in menuButtons[subMenuIndex].value {
                viewController.subMenuBarStackView.insertArrangedSubview(subMenuButton, at: stackViewIndex)
                stackViewIndex += 1
            }
            viewController.subMenuBarStackView.isHidden = false
        }
        viewController.topMenuBarStackView.isHidden = false
    }
    
}
