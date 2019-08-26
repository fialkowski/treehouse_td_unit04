//
//  InputDataValidator.swift
//  AmusementParkPassGenerator
//
//  Created by Nikolay Fialkowski on 2019-08-25.
//  Copyright © 2019 nikko444. All rights reserved.
//

import Foundation
import UIKit


extension String {
    var nameValidated: String {
        let charSet = CharacterSet(charactersIn: " .\'’abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
        let cleanedString = self.components(separatedBy: charSet).joined(separator: "")
        let components = cleanedString.components(separatedBy: .whitespacesAndNewlines)
        let trimmedString = components.filter { !$0.isEmpty }.joined(separator: " ")
        let trimmedCapitalizedOutput = trimmedString.capitalized
        return trimmedCapitalizedOutput
    }
    
    var ssnValidated: String {
        let charSet = CharacterSet(charactersIn: " -1234567890").inverted
        let strippedString = self.components(separatedBy: charSet).joined(separator: "")
        return String(strippedString.prefix(15))
        
    }
    
    var projectNumberValidated: String {
        let charSet = CharacterSet(charactersIn: "1234567890").inverted
        let strippedString = self.components(separatedBy: charSet).joined(separator: "")
        return String(strippedString.prefix(7))
        
    }
    
    var zipValidated: String {
        let charSet = CharacterSet(charactersIn: "1234567890").inverted
        let strippedString = self.components(separatedBy: charSet).joined(separator: "")
        return String(strippedString.prefix(5))
    }
    
    var strippedNumbers: String {
        return self.filter("01234567890".contains)
    }
    
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
    
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }
}


class InputDataValidator {
    static func ssnFormatter (for textField: UITextField) {
        if let text = textField.text {
            var validatedInput = text.ssnValidated
            
            if validatedInput.strippedNumbers.count == 4 &&
                validatedInput.firstIndex(of: "-") == nil {
                
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 3))
                validatedInput.insert("-", at: validatedInput.index(validatedInput.startIndex, offsetBy: 4))
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 5))
                
            } else if validatedInput.strippedNumbers.count == 6 &&
                validatedInput.firstIndex(of: "-") == validatedInput.lastIndex(of: "-") {
                
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 8))
                validatedInput.insert("-", at: validatedInput.index(validatedInput.startIndex, offsetBy: 9))
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 10))
                
            } else if validatedInput.strippedNumbers.count > 3 &&
                validatedInput.strippedNumbers.count < 7 &&
                validatedInput.firstIndex(of: "-") == nil {
                
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 3))
                validatedInput.insert("-", at: validatedInput.index(validatedInput.startIndex, offsetBy: 4))
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 5))
                
            } else if validatedInput.strippedNumbers.count > 3 &&
                validatedInput.strippedNumbers.count < 7 &&
                validatedInput.firstIndex(of: "-") == nil {
                
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 3))
                validatedInput.insert("-", at: validatedInput.index(validatedInput.startIndex, offsetBy: 4))
                validatedInput.insert(" ", at: validatedInput.index(validatedInput.startIndex, offsetBy: 5))
            }
            textField.text = validatedInput
        }
    }
}
