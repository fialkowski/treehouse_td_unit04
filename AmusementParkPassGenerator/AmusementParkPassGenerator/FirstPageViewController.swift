//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-03-04.
//  Copyright © 2019 nikko444. All rights reserved.
//

import UIKit

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
    
    func setButtonsStyleTo (_ color: UIColor, _ font: UIFont) {
        guard let buttonArray = self.arrangedSubviews as? [UIButton] else {
            return
        }
        for button in buttonArray { button.titleLabel?.font = font; button.setTitleColor(color, for: .normal) }
    }
    
}

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
    
        static var background: UIColor { return UIColor(red: 218/255.0, green: 214/255.0, blue: 222/255.0, alpha: 1.0) }
}

protocol FirstPageAssignable where Self: UIViewController {
    var topMenuBarStackView: UIStackView! { get }
    var subMenuBarStackView: UIStackView! { get }
}

class FirstPageViewController: UIViewController, FirstPageAssignable {

    @IBOutlet weak var topMenuBarStackView: UIStackView!
    @IBOutlet weak var subMenuBarStackView: UIStackView!
    
    var mainMenuHandler: MainMenuHandler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            mainMenuHandler = try MainMenuHandler(viewController: self,
                                                  source: MainMenuInterpreter.retrieve(from:
                                                    FileReader.read(from: "mainMenu", ofType: "plist")))
            
        } catch MainMenuRetriverError.invalidMainMenuFileNameOrType {
            AlertController.showFatalError(for: MainMenuRetriverError.invalidMainMenuFileNameOrType)
        } catch MainMenuRetriverError.corruptMainMenuFileOrWrongFormat {
            AlertController.showFatalError(for: MainMenuRetriverError.corruptMainMenuFileOrWrongFormat)
        } catch let error {
            AlertController.showFatalError(for: error)
        }
        mainMenuHandler?.setMainMenu()
    }
}
