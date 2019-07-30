//
//  MenuButtonHandler.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-07-28.
//  Copyright © 2019 nikko444. All rights reserved.
//

import UIKit

//enum menuButtonHandlerError: Error {
//    case numberOfTopRowCaptionsDoesntMatch
//    case numberOfTopRowCaptionsDoesntMatch
//}

enum ButtonRow: CaseIterable {
    case topMenu
    case subMenu
}


class MenuButtonHandler {
    private let topMenuButtons:[UIButton]
    private let subMenuButtons:[UIButton]
    private let topMenuCaptions:[TopMenuCaption]
    
    init (topMenuButtons: [UIButton], subMenuButtons: [UIButton], topMenuCaptions: [TopMenuCaption]) {
        self.topMenuButtons = topMenuButtons
        self.subMenuButtons = subMenuButtons
        self.topMenuCaptions = topMenuCaptions
        
        if topMenuCaptions.count == topMenuButtons.count {
            topMenuButtons.forEach {$0.setTitle(topMenuCaptions[topMenuButtons.firstIndex(of: $0) ?? 0].rawValue, for: .normal)}
            } else {
                //TODO: Throw something that shows a faulty data
            }
    }

    
    private func deactivate(_ button: UIButton, with color: UIColor) -> Void {
        button.setTitleColor(color, for: .normal)
    }
    
    func set(_ subMenu: [ButtonAssignable]) {
        subMenuButtons.forEach {$0.setTitle(subMenu[subMenuButtons.firstIndex(of: $0) ?? 0].text, for: .normal)}
    }
    
    func deactivate(_ row: ButtonRow) {
        switch row {
        case .topMenu: do {self.topMenuButtons.forEach {self.deactivate($0, with: .topMenuButtonInactive)}}
        case .subMenu: do {self.subMenuButtons.forEach {self.deactivate($0, with: .subMenuButtonInactive)}}
        }
    }
    
}
