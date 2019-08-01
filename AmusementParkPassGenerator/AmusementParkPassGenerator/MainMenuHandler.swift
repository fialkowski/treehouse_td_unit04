//
//  MainMenuHandler.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-01.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

class MainMenuHandler {

    let viewController: FirstPageAssignable
    let source: [String:[String]]
    let tempBtn = UIButton(type: .system)

    init (viewController: FirstPageAssignable, source: [String:[String]]) {
        self.viewController = viewController
        self.source = source
    }
    
    func setMainMenu() {
        viewController.topMenuBarStackView.setBackground(to: .topMenuBarColor)
        viewController.subMenuBarStackView.setBackground(to: .subMenuBarColor)
        
        tempBtn.setTitle("Click here", for: .normal)
        tempBtn.tintColor = .white
        tempBtn.backgroundColor = .red
        tempBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        viewController.topMenuBarStackView.insertArrangedSubview(tempBtn, at: 0)
    }
    
    @objc func buttonClicked(sender : UIButton){
        let alert = UIAlertController(title: "Clicked", message: "You have clicked on the button", preferredStyle: .alert)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
