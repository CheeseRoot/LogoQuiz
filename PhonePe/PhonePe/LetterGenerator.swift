//
//  LetterGenerator.swift
//  PhonePe
//
//  Created by Sudhanshu Singh on 15/02/20.
//  Copyright © 2020 self. All rights reserved.
//

import UIKit

final class LetterGenerator {

    static let RANDOM_LETTER_COUNT = 12
    
    static func generateRandomLetters(containing input: String, length: Int = LetterGenerator.RANDOM_LETTER_COUNT) -> [Character] {
        
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        let ramainingLength = length-input.count
        
        let randomFromAllChars = String((0..<ramainingLength).map{ _ in letters.randomElement()! })
        
        let finalString = input + randomFromAllChars
        
        return finalString.shuffled()
    }
}
