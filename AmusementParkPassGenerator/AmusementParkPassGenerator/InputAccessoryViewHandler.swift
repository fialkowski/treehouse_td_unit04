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
    
    let accessoryView: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .lightGray
        accessoryView.alpha = 0.8
        return accessoryView
    }()
    
    private let cancelButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("Clear", for: .normal)
        cancelButton.setTitleColor(.purple, for: .normal)
        cancelButton.showsTouchWhenHighlighted = true
        return cancelButton
    }()
    
    private let previousButton: UIButton = {
        let previousButton = UIButton(type: .custom)
        previousButton.setTitle("Previous", for: .normal)
        previousButton.setTitleColor(.purple, for: .normal)
        previousButton.showsTouchWhenHighlighted = true
        previousButton.alpha = 0.6
        return previousButton
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.textColor = UIColor.subMenuBarColor
        titleLabel.alpha = 0.7
        titleLabel.font = UIFont.subMenuButtonActive
        return titleLabel
    }()
    
    private let nextButton: UIButton = {
        let nextButton = UIButton(type: .custom)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.purple, for: .normal)
        nextButton.showsTouchWhenHighlighted = true
        nextButton.alpha = 0.6
        return nextButton
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
    
    func setAccessoryViewTargetTo (_ target: UIView, withLabel label: UILabel = UILabel()) {
        
        if let textLabel = label.text {
            titleLabel.text = textLabel
        }

        inputProperty = target
        doneButton.addTarget(self, action: #selector(finishInput), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissInput), for: .touchUpInside)

        accessoryView.frame = CGRect(x: 0, y: 0, width: viewController.view.frame.width, height: 45)
        accessoryView.addSubview(cancelButton)
        
        accessoryView.addSubview(titleLabel)
        
        accessoryView.addSubview(doneButton)
        
        let allChildViews = Mirror(reflecting: self).children.compactMap { $0.value as? UIView}
        allChildViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: accessoryView.leadingAnchor, constant: 20),
            cancelButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: accessoryView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: accessoryView.trailingAnchor, constant: -20),
            doneButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor)
            ])
        
        if getActiveInputFields().count != 1 {
            nextButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
            previousButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
            accessoryView.addSubview(previousButton)
            accessoryView.addSubview(nextButton)
            NSLayoutConstraint.activate([
                previousButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 30),
                previousButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor),
                nextButton.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -30),
                nextButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor)
            ])
        }
    }
    
    private func getActiveInputFields() -> [UITextField] {
        let allInputFields = Mirror(reflecting: viewController).children.compactMap { $0.value as? UITextField }
        return allInputFields.filter { $0.isEnabled == true }
    }
    
    @objc private func dismissInput() {
        if let textFieldProperty = inputProperty as? UITextField {
            textFieldProperty.text = ""
        }
    }
    
    @objc private func finishInput() {
        inputProperty?.endEditing(true)
    }
    
    #warning("This block doesn't work because of the parameter")
    @objc private enum Iterate: Int { case previousField, nextField }
    
    @objc private func moveTo(_ direction: Iterate) {
        let activeInputFields = getActiveInputFields()
        let enabledInputTextFieldsTags = activeInputFields.map { $0.tag }
        var sortedEnabledTags: [Int]
        switch direction {
        case .previousField: sortedEnabledTags = enabledInputTextFieldsTags.sorted { $0 > $1 }
        case .nextField: sortedEnabledTags = enabledInputTextFieldsTags.sorted { $0 < $1 }
        }
        //let sortedEnabledTags = enabledInputTextFieldsTags.sorted { $0 < $1 }
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
    
//    @objc private func previousField() {
//        let activeInputFields = getActiveInputFields()
//        let enabledInputTextFieldsTags = activeInputFields.map { $0.tag }
//        let sortedEnabledTags = enabledInputTextFieldsTags.sorted { $0 > $1 }
//        var nextFieldTag: Int = 0
//        guard let currentTag = inputProperty?.tag else { return }
//        if sortedEnabledTags.last == currentTag {
//            nextFieldTag = sortedEnabledTags.first!
//        } else {
//            guard let index = sortedEnabledTags.firstIndex(of: currentTag) else { return }
//            nextFieldTag = sortedEnabledTags[index + 1]
//        }
//
//        let nextTextField = activeInputFields.filter { $0.tag == nextFieldTag }
//        nextTextField.first?.becomeFirstResponder()
//    }

}
