//
//  MenuDataModel.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 24.06.2023.
//

import Foundation

class MenuDataModel {
    private init() { }
    
    static func getBannersData() -> [String] {
        [
            "Demo Banner 1",
            "Demo Banner 2",
            "Demo Banner 1",
            "Demo Banner 2",
            "Demo Banner 1",
            "Demo Banner 2"
        ]
    }
    
    static func getMenuSectionsData() -> [MenuSectionCellData] {
        [
            MenuSectionCellData(title: "Пицца", isActive: true),
            MenuSectionCellData(title: "Комбо"),
            MenuSectionCellData(title: "Десерты"),
            MenuSectionCellData(title: "Напитки")
        ]
    }
    
    static func getMenuElementsData() -> [Section: [MenuElementData]] {
        let menuElementsData = [
            MenuElementData(
                imageName: "Pizza 1",
                title: "Ветчина и грибы",
                subtitle: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус",
                price: "от 345 р",
                section: .pizza
            ),
            MenuElementData(
                imageName: "Pizza 2",
                title: "Баварские колбаски",
                subtitle: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус",
                price: "от 345 р",
                section: .pizza
            ),
            MenuElementData(
                imageName: "Pizza 3",
                title: "Нежный лосось",
                subtitle: "Лосось, томаты черри, моцарелла, соус песто",
                price: "от 345 р",
                section: .pizza
            ),
            MenuElementData(
                imageName: "KFC Combo",
                title: "Сандерс Меню",
                subtitle: "Крылья, ножки + напиток",
                price: "от 500 р",
                section: .combo
            ),
            MenuElementData(
                imageName: "Bubble Tea",
                title: "Bubble Tea",
                subtitle: "Час с шариками тапиока",
                price: "от 150 р",
                section: .drinks
            ),
            MenuElementData(
                imageName: "Cinnamon Roll",
                title: "Cinnamon Rolls",
                subtitle: "Оригинальный десерт с корицей",
                price: "от 450 р",
                section: .deserts
            )
        ]
        
        var menuElementsDataBySection: [Section: [MenuElementData]] = [:]
        
        for section in Section.allCases {
            let sectionElements = menuElementsData.filter { $0.section == section }
            menuElementsDataBySection[section] = sectionElements
        }
        
        return menuElementsDataBySection
    }
}
