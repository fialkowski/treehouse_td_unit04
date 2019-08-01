//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by nikko444 on 2019-03-04.
//  Copyright © 2019 nikko444. All rights reserved.
//

import UIKit

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
    
    var topMenuButton1: UIButton! { get }
    var topMenuButton2: UIButton! { get }
    var topMenuButton3: UIButton! { get }
    var topMenuButton4: UIButton! { get }
    
    var subMenuButton1: UIButton! { get }
    var subMenuButton2: UIButton! { get }
    var subMenuButton3: UIButton! { get }
    var subMenuButton4: UIButton! { get }
    var subMenuButton5: UIButton! { get }
}

class FirstPageViewController: UIViewController, FirstPageAssignable {

    @IBOutlet weak var topMenuBarStackView: UIStackView!
    @IBOutlet weak var subMenuBarStackView: UIStackView!
    
    @IBOutlet weak var topMenuButton1: UIButton!
    @IBOutlet weak var topMenuButton2: UIButton!
    @IBOutlet weak var topMenuButton3: UIButton!
    @IBOutlet weak var topMenuButton4: UIButton!
    
    @IBOutlet weak var subMenuButton1: UIButton!
    @IBOutlet weak var subMenuButton2: UIButton!
    @IBOutlet weak var subMenuButton3: UIButton!
    @IBOutlet weak var subMenuButton4: UIButton!
    @IBOutlet weak var subMenuButton5: UIButton!
    
    
    @IBAction func topMenuButtonPress(_ sender: UIButton) {
 
    }
    
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
        print(mainMenuHandler?.source ?? "GFU")
        mainMenuHandler?.setMainMenu()
    }
}
