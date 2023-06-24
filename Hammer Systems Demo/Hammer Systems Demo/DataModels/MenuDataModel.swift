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
    
    static func getMenuElementsData() -> [MenuElementData] {
        [
            MenuElementData(imageName: "Pizza 1", title: "Ветчина и грибы", subtitle: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 2", title: "Баварские колбаски", subtitle: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 3", title: "Нежный лосось", subtitle: "Лосось, томаты черри, моцарелла, соус песто", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 1", title: "Ветчина и грибы", subtitle: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 2", title: "Баварские колбаски", subtitle: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 3", title: "Нежный лосось", subtitle: "Лосось, томаты черри, моцарелла, соус песто", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 1", title: "Ветчина и грибы", subtitle: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 2", title: "Баварские колбаски", subtitle: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 3", title: "Нежный лосось", subtitle: "Лосось, томаты черри, моцарелла, соус песто", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 1", title: "Ветчина и грибы", subtitle: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 2", title: "Баварские колбаски", subtitle: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", price: "от 345 р"),
            MenuElementData(imageName: "Pizza 3", title: "Нежный лосось", subtitle: "Лосось, томаты черри, моцарелла, соус песто", price: "от 345 р"),
        ]
    }
}
