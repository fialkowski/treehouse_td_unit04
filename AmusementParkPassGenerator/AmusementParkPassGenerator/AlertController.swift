//
//  AlertController.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-07-30.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}

 class AlertController {
    
    static func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        alertController.show()
    }
    
    static func showFatalError (for error: Error) {
        let alertController = UIAlertController(title: "Oops, we got a fatal error here", message: "\(error)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: crash) //Passing a function with NO parameters
        alertController.addAction(okAction)
        alertController.show()
    }
    
    private static func crash(sender: UIAlertAction) -> Void {
        fatalError("\(sender.title ?? "")")
    }
}

