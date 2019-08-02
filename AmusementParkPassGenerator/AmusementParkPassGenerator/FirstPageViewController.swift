//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-03-04.
//  Copyright © 2019 nikko444. All rights reserved.
//

import UIKit

extension UIView {
    func hideAnimated(in stackView: UIStackView) {
        if !self.isHidden {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = true
                    stackView.layoutIfNeeded()
            },
                completion: nil
            )
        }
    }
    
    func showAnimated(in stackView: UIStackView) {
        if self.isHidden {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = false
                    stackView.layoutIfNeeded()
            },
                completion: nil
            )
        }
    }
}

extension UIStackView {
    func setBackground(to color: UIColor) {
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
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        //NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension UIFont {
        static var labelDefault: UIFont { return UIFont(name:"HelveticaNeue-Bold", size: 17.0)! }
        static var labelBold: UIFont { return UIFont(name:"HelveticaNeue-Bold", size: 19.0)! }
        static var buttonDefault: UIFont { return UIFont(name:"HelveticaNeue", size: 16.0)! }
        static var buttonBold: UIFont { return UIFont(name:"HelveticaNeue-Bold", size: 17.0)! }
    
        static var topMenuButtonInactive: UIFont { return UIFont.systemFont(ofSize: 19.0) }
        static var topMenuButtonActive: UIFont { return UIFont.systemFont(ofSize: 19.0, weight: .bold) }
}

extension UIColor {
        static var topMenuBarColor: UIColor  { return UIColor(red: 138/255.0, green: 109/255.0, blue: 170/255.0, alpha: 1.0) }
        static var subMenuBarColor: UIColor { return UIColor(red: 61/255.0, green: 55/255.0, blue: 71/255.0, alpha: 1.0) }
        static var menuButtonActive: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
        static var topMenuButtonInactive: UIColor { return UIColor(red: 206/255.0, green: 193/255.0, blue: 222/255.0, alpha: 1.0) }
        static var subMenuButtonInactive: UIColor { return UIColor(red: 131/255.0, green: 124/255.0, blue: 141/255.0, alpha: 1.0) }
}

extension UIButton {
    func enable () {
        self.isEnabled = true
    }
    func disable () {
        self.isEnabled = false
    }
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
        print(mainMenuHandler?.menuButtons ?? "GFU")
        mainMenuHandler?.setMainMenu()
    }
}
