//
//  MenuElementData.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 24.06.2023.
//

import Foundation

struct MenuElementData {
    let imageName: String
    let title: String
    let subtitle: String
    let price: String
    let section: Section
    
    enum Section {
        case pizza, combo, deserts, drinks
    }
}
