//
//  DataProviders.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-07-30.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit


enum MainMenuRetriverError: String, Error {
    case invalidMainMenuFileNameOrType
    case corruptMainMenuFileOrWrongFormat
}

class FileReader {
    static func read (from file: String, ofType type: String) throws -> [String : Any] {
        guard let path = Bundle.main.path(forResource: file, ofType: type) else {
            throw MainMenuRetriverError.invalidMainMenuFileNameOrType
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            throw MainMenuRetriverError.corruptMainMenuFileOrWrongFormat
        }
        return dictionary
    }
}

class MainMenuInterpreter {
    static func retrieve (from dictionary: [String: Any]) throws -> [String:[String]]{
        var output = [String: [String]]()
        for (key, value) in dictionary {
            guard let array = value as? [String: Any] else {
                throw MainMenuRetriverError.corruptMainMenuFileOrWrongFormat
            }
            let returnArray = array.map { $0.key }
            output.updateValue(returnArray, forKey: key)
        }
        return output
    }
}

    
#warning("MoveMainMenuHandlerToAnotherFile!!!")

class MainMenuHandler {
    let topStackView: UIStackView
    let bottomStackView: UIStackView
    let source: [String:[String]]
    init (topStackView: UIStackView, bottomStackView: UIStackView, source: [String:[String]]) {
        self.topStackView = topStackView
        self.bottomStackView = bottomStackView
        self.source = source
    }
}
