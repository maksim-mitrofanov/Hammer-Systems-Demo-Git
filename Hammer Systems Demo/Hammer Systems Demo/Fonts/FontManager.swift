//
//  FontManager.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 23.06.2023.
//

import UIKit

class FontManager {
    private init() { }
    
    static func getAllFontNames() -> [String] {
        var fonts = [String]()
        
        for familyName in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                fonts.append(fontName)
            }
        }
        
        return fonts
    }
}
