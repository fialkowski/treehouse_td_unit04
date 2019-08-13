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
    private let viewController: PassDataInputCompliant
    private var inputProperty: UIView?
    private let cancelButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("Cancel Input", for: .normal)
        cancelButton.setTitleColor(UIColor.topMenuBarColor, for: .normal)
        cancelButton.showsTouchWhenHighlighted = true
        return cancelButton
    }()
    
    private let doneButton: UIButton = {
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
        doneButton.addTarget(self, action: #selector(nextField), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissInput), for: .touchUpInside)

        accessoryView.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: 45)
        accessoryView.addSubview(cancelButton)
        accessoryView.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: accessoryView.leadingAnchor, constant: 20),
            cancelButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: accessoryView.trailingAnchor, constant: -20),
            doneButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor)
            ])
        
        return accessoryView
    }
    
    @objc private func dismissInput() {
        inputProperty?.endEditing(true)
        if let textFieldProperty = inputProperty as? UITextField {
            textFieldProperty.text = ""
        }
    }
    
    @objc private func finishInput() {
        inputProperty?.endEditing(true)
    }
    
    @objc private func nextField() {
        let allInputFields = Mirror(reflecting: viewController).children.compactMap { $0.value as? UITextField }
        let activeInputFields = allInputFields.filter { $0.isEnabled == true }
        let enabledInputTextFieldsTags = activeInputFields.map { $0.tag }
        let sortedEnabledTags = enabledInputTextFieldsTags.sorted { $0 < $1 }
        var nextFieldTag: Int = 0
        guard let currentTag = inputProperty?.tag else { return }
        if sortedEnabledTags.last == currentTag {
            nextFieldTag = sortedEnabledTags.first!
        } else {
            guard let index = sortedEnabledTags.firstIndex(of: currentTag) else { return }
            nextFieldTag = sortedEnabledTags[index + 1]
        }
        
        let nextTextField = activeInputFields.filter { $0.tag == nextFieldTag }
        nextTextField.first?.becomeFirstResponder()
    }

}
