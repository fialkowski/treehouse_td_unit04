//
//  UIButtonRelatedExtensions.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-05.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static var topMenuButtonInactive: UIFont { return UIFont.systemFont(ofSize: 19.0) }
    static var topMenuButtonActive: UIFont { return UIFont.systemFont(ofSize: 19.0, weight: .bold) }
    static var subMenuButtonInactive: UIFont { return UIFont.systemFont(ofSize: 17.0) }
    static var subMenuButtonActive: UIFont { return UIFont.systemFont(ofSize: 17.0, weight: .bold) }
    
    static var label: UIFont { return UIFont.systemFont(ofSize: 18.0, weight: .bold) }
}

extension UIColor {
    static var topMenuBarColor: UIColor  { return UIColor(red: 138/255.0, green: 109/255.0, blue: 170/255.0, alpha: 1.0) }
    static var subMenuBarColor: UIColor { return UIColor(red: 61/255.0, green: 55/255.0, blue: 71/255.0, alpha: 1.0) }
    static var menuButtonActive: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
    static var topMenuButtonInactive: UIColor { return UIColor(red: 206/255.0, green: 193/255.0, blue: 222/255.0, alpha: 1.0) }
    static var subMenuButtonInactive: UIColor { return UIColor(red: 131/255.0, green: 124/255.0, blue: 141/255.0, alpha: 1.0) }
    
    static var labelActive: UIColor { return UIColor(red: 71/255.0, green: 70/255.0, blue: 73/255.0, alpha: 1.0) }
    static var labelInactive: UIColor { return UIColor(red: 154/255.0, green: 151/255.0, blue: 157/255.0, alpha: 1.0) }
    
    static var textFieldActive: UIColor { return UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1.0) }
    static var textFieldBorderActive: UIColor { return UIColor(red: 161/255.0, green: 158/255.0, blue: 165/255.0, alpha: 1.0) }
    static var textFieldBorderInactive: UIColor { return UIColor(red: 194/255.0, green: 190/255.0, blue: 197/255.0, alpha: 1.0) }
    
    static var background: UIColor { return UIColor(red: 218/255.0, green: 214/255.0, blue: 222/255.0, alpha: 1.0) }
    
    static var generateButton: UIColor { return UIColor(red: 103/255.0, green: 147/255.0, blue: 143/255.0, alpha: 1.0) }
    static var generateButtonFont: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
    
    static var populateButton: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
    static var populateButtonFont: UIColor { return UIColor(red: 103/255.0, green: 147/255.0, blue: 143/255.0, alpha: 1.0) }
}

extension UIButton {
    
    private enum Transparency: CGFloat {
        case opaque = 1.0
        case faded = 0.4
        case invisible = 0.0
    }
    
    enum Style {
        case generate
        case populate
        case topMenuActive
        case topMenuInactive
        case subMenuActive
        case subMenuInactive
    }
    
    private func setTransparency (_ toValue: Transparency) {
        self.alpha = toValue.rawValue
    }
    
    func disable () {
        self.isEnabled = false
        self.setTransparency(.faded)
    }
    
    func enable () {
        self.isEnabled = true
        self.setTransparency(.opaque)
    }
    
    func setStyle (to style: Style) {
        switch style {
        case .generate:
            self.layer.cornerRadius = 3.0;
            self.backgroundColor = .generateButton
            self.setTitleColor(.generateButtonFont, for: .normal)
        case .populate:
            self.layer.cornerRadius = 3.0
            self.backgroundColor = .populateButton
            self.setTitleColor(.populateButtonFont, for: .normal)
        case .topMenuActive:
            self.titleLabel?.font = .topMenuButtonActive
            self.setTitleColor(.menuButtonActive, for: .normal)
            self.backgroundColor = nil
        case .topMenuInactive:
            self.titleLabel?.font = .topMenuButtonInactive
            self.setTitleColor(.topMenuButtonInactive, for: .normal)
            self.backgroundColor = nil
        case .subMenuActive:
            self.titleLabel?.font = .subMenuButtonActive
            self.setTitleColor(.menuButtonActive, for: .normal)
            self.backgroundColor = nil
        case .subMenuInactive:
            self.titleLabel?.font = .subMenuButtonInactive
            self.setTitleColor(.subMenuButtonInactive, for: .normal)
            self.backgroundColor = nil
        }
    }
}

extension UITextField {
    private enum Style {
        case enabled
        case disabled
    }
    
    func disable () {
        setStyle(to: .disabled)
    }
    
    func enable () {
        setStyle(to: .enabled)
    }
    
    private func setStyle (to style: Style) {
        
        switch style {
        case .enabled:
            self.isEnabled = true
            self.backgroundColor = .textFieldActive
            self.layer.cornerRadius = 3.0
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor.textFieldBorderActive.cgColor
        case .disabled:
            self.isEnabled = false
            self.backgroundColor = .background
            self.layer.cornerRadius = 3.0
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor.textFieldBorderInactive.cgColor
        }
    }
}

extension UILabel {
    func enable () {
        self.font = UIFont.label
        self.textColor = UIColor.labelActive
    }
    
    func disable () {
        self.font = UIFont.label
        self.textColor = UIColor.labelInactive
    }
}

extension UIStackView {
    func setBackground (to color: UIColor) {
        let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = color
            return view
        }()
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        self.insertSubview(backgroundView, at: 0)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
    
    func removeAllArrangedSubviews () {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
