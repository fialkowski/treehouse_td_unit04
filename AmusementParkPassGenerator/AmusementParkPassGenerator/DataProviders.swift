//
//  DataProviders.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-07-30.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit

protocol DataProvider {
    associatedtype Data
    
    var data: Data { get }
}

enum MainMenuRetriverError: String, Error {
    case invalidMainMenuFileNameOrType
    case corruptMainMenuFileOrWrongFormat
}

struct MainMenuRetriever: DataProvider {
    typealias Data = [String: AnyObject]
    
    var data: [String: AnyObject]
    
    init (from file: String, ofType type: String) throws {
    
            guard let path = Bundle.main.path(forResource: file, ofType: type) else {
                throw MainMenuRetriverError.invalidMainMenuFileNameOrType
            }
        #warning("This has to be a 2-step process of dictionary unwrapping")
            guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
                throw MainMenuRetriverError.corruptMainMenuFileOrWrongFormat
            }
            self.data = dictionary
        }

}
    
#warning("MoveMainMenuHandlerToAnotherFile!!!")

class MainMenuHandler<TopStackView: UIStackView, BottomStackView: UIStackView, Source: DataProvider> {
    let topStackView: TopStackView
    let bottomStackView: BottomStackView
    let source: Source
    init (topStackView: TopStackView, bottomStackView: BottomStackView, source: Source) {
        self.topStackView = topStackView
        self.bottomStackView = bottomStackView
        self.source = source
    }
}
