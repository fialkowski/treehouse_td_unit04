//
//  InputAccessoryViewHandler.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-08.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

class InputAccessoryViewHandler {
    let viewController: PassDataInputCompliant
    var inputProperty: UIView?
    let cancelButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
        //#warning("Think if you can make this field to pick up the Input Fields's name")
        cancelButton.setTitle("Cancel Input", for: .normal)
        cancelButton.setTitleColor(UIColor.topMenuBarColor, for: .normal)
        cancelButton.showsTouchWhenHighlighted = true
        return cancelButton
    }()
    
    let doneButton: UIButton = {
        let doneButton = UIButton(type: .custom)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.purple, for: .normal)
        doneButton.showsTouchWhenHighlighted = true
        return doneButton
    }()
    
    init (forViewController viewController: PassDataInputCompliant) {
        self.viewController = viewController
    }
    
    func setAccessoryViewTargetTo (_ target: UIView, withLabel label: UILabel = UILabel()) -> UIView {
        let accessoryView: UIView = {
            let accessoryView = UIView(frame: .zero)
            accessoryView.backgroundColor = .lightGray
            accessoryView.alpha = 0.8
            return accessoryView
        }()
        
        if let textLabel = label.text {
            cancelButton.setTitle("Clear field \"\(textLabel)\"", for: .normal)
        }

        inputProperty = target
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(finishInput), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissInput), for: .touchUpInside)
        let cancelButtonLeading = NSLayoutConstraint(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: accessoryView, attribute: .leading, multiplier: 1.0, constant: 20)
        let cancelButtonCenterY = NSLayoutConstraint(item: cancelButton, attribute: .centerY, relatedBy: .equal, toItem: accessoryView, attribute: .centerY, multiplier: 1.0, constant: 0)
        let doneButtonTrailing = NSLayoutConstraint(item: doneButton, attribute: .trailing, relatedBy: .equal, toItem: accessoryView, attribute: .trailing, multiplier: 1.0, constant: -20)
        let doneButtonCenterY = NSLayoutConstraint(item: doneButton, attribute: .centerY, relatedBy: .equal, toItem: accessoryView, attribute: .centerY, multiplier: 1.0, constant: 0)
        accessoryView.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: 45)
        accessoryView.addSubview(cancelButton)
        accessoryView.addSubview(doneButton)
        cancelButtonLeading.isActive = true
        cancelButtonCenterY.isActive = true
        doneButtonTrailing.isActive = true
        doneButtonCenterY.isActive = true
        return accessoryView
    }
    
    @objc func dismissInput() {
        inputProperty?.endEditing(true)
        if let textFieldProperty = inputProperty as? UITextField {
            textFieldProperty.text = ""
        }
    }
    
    @objc func finishInput() {
        inputProperty?.endEditing(true)
    }

}
