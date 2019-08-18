//
//  AlertController.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-07-30.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

extension String {
    struct WarningCaptions {
        static var engUsChangeScreenWaringTitle: String { return "Do you still want to proceed?" }
        static var engUsChangeScreenWaringMessage: String { return "You are about to leave the current screen, but you got something filled out already!" }
    }
}

public extension UIAlertController {
    func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        window.rootViewController = viewController
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        viewController.present(self, animated: true, completion: nil)
    }
}

 class AlertController {
    
    static func showSingleActionAlertWith (title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        alertController.show()
    }
    
    static func showInputScreenClearWarningWith (title: String, message: String, style: UIAlertController.Style = .alert, okAction: @escaping (UIAlertAction) ->()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
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

