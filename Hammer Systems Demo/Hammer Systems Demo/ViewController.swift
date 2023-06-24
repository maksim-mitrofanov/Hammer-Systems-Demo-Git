//
//  ViewController.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 23.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var selectRegionButton: UIButton!
    @IBOutlet private weak var specialOffersView: SpecialOffersView!
    @IBOutlet private weak var menuSectionsView: MenuSectionsView!
    @IBOutlet private weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegionsButton()
        setupOffersView()
        setupMenuSectionsView()
        setupMenuTableView()
    }
    
    var bannersData = [
        "Demo Banner 1",
        "Demo Banner 2",
        "Demo Banner 1",
        "Demo Banner 2",
        "Demo Banner 1",
        "Demo Banner 2",
    ]
    
    var menuSectionsData = [
        MenuSectionCellData(title: "Пицца", isActive: true),
        MenuSectionCellData(title: "Комбо"),
        MenuSectionCellData(title: "Десерты"),
        MenuSectionCellData(title: "Напитки")
    ]
    
    var menuElementsData = [
        MenuElementData(imageName: "Pizza 1", title: "Ветчина и грибы", subtitle: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус", price: "от 345 р"),
        MenuElementData(imageName: "Pizza 2", title: "Баварские колбаски", subtitle: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", price: "от 345 р"),
        MenuElementData(imageName: "Pizza 3", title: "Нежный лосось", subtitle: "Лосось, томаты черри, моцарелла, соус песто", price: "от 345 р"),
    ]
}

// MARK: - MenuTableView
extension ViewController: UITableViewDataSource {
    var tableViewCellID: String { "MenuElementTableViewCell" }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuElementsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID) as! MenuElementTableViewCell
        
        cell.setup(with: menuElementsData[indexPath.row])
        return cell
    }
    
    func setupMenuTableView() {
        menuTableView.register(MenuElementTableViewCell.self, forCellReuseIdentifier: tableViewCellID)
        menuTableView.dataSource = self
        menuTableView.layer.cornerRadius = 30
    }
}

// MARK: - SpecialOffersView
extension ViewController: SpecialOffersViewDelegate, SpecialOffersViewDataSource {
    private func setupOffersView() {
        specialOffersView.backgroundColor = .clear
        specialOffersView.dataSource = self
        specialOffersView.delegate = self
    }
    
    func didTapElement(at indexPath: IndexPath) {
        specialOffersView.shouldReloadData = true
    }
    
    func imageNameForCell(at indexPath: IndexPath) -> String {
        bannersData[indexPath.row]
    }
    
    func numberOfElements() -> Int {
        bannersData.count
    }
}

// MARK: - MenuSectionsView {
extension ViewController: MenuSectionsViewDelegate, MenuSectionsViewDataSource {
    private func setupMenuSectionsView() {
        menuSectionsView.backgroundColor = .clear
        menuSectionsView.dataSource = self
        menuSectionsView.delegate = self
    }
    
    func didSelectMenuSection(at indexPath: IndexPath) {
        menuSectionsData.indices.forEach { menuSectionsData[$0].isActive = false }
        menuSectionsData[indexPath.row].isActive = true
        menuSectionsView.shouldReloadData = true
    }
    
    func numberOfMenuSections() -> Int {
        menuSectionsData.count
    }
    
    func menuSectionData(at indexPath: IndexPath) -> MenuSectionCellData {
        menuSectionsData[indexPath.row]
    }
}

// MARK: - SelectRegionButton
private extension ViewController {
    func setupRegionsButton() {
        setupRegionsButtonAppearance()
        setupRegionMenuButtonOptions()
        selectRegionButton.showsMenuAsPrimaryAction = true
    }
    
    func setupRegionsButtonAppearance() {
        selectRegionButton.tintColor = UIColor(named: "TitleTextColor")
        selectRegionButton.semanticContentAttribute = .forceRightToLeft
        
        var configuration = UIButton.Configuration.plain()
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        
        let chevronImage = UIImage(systemName: "chevron.down")
        configuration.image = chevronImage
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .small)
        
        selectRegionButton.configuration = configuration
    }
    
    func setupRegionMenuButtonOptions() {
        let regions = ["Москва", "Санкт Петербург", "Казань", "Екатеринбург"]
        var menuActions = [UIAction]()
        
        for region in regions {
            let action = UIAction(title: region, image: nil) { [weak self] _ in
                self?.selectRegion(named: region)
            }
            menuActions.append(action)
        }
        
        let menu = UIMenu(title: "Выбери свой регион", children: menuActions)
        selectRegionButton.menu = menu
    }
    
    func selectRegion(named regionName: String) {
        selectRegionButton.setTitle(regionName, for: .normal)
    }
}


