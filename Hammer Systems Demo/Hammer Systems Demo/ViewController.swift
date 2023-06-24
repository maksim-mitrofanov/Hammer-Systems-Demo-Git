//
//  ViewController.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 23.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var selectRegionButton: UIButton!
    private var specialOffersView: SpecialOffersView!
    private var menuSectionsView: MenuSectionsView!
    private var menuTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

extension ViewController {
    func setupUI() {
        scrollView = UIScrollView()
        contentView = UIView()
        selectRegionButton = UIButton()
        specialOffersView = SpecialOffersView()
        menuSectionsView = MenuSectionsView()
        menuTableView = UITableView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        selectRegionButton.translatesAutoresizingMaskIntoConstraints = false
        specialOffersView.translatesAutoresizingMaskIntoConstraints = false
        menuSectionsView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(selectRegionButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(specialOffersView)
        view.addSubview(menuSectionsView)
        contentView.addSubview(menuTableView)
        
        setupRegionsButton()
        setupOffersView()
        setupMenuSectionsView()
        setupMenuTableView()
        
        NSLayoutConstraint.activate([
            selectRegionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            selectRegionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Pin scrollView to the edges of the main view
            scrollView.topAnchor.constraint(equalTo: selectRegionButton.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Pin contentView to the edges of the scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            specialOffersView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            specialOffersView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            specialOffersView.heightAnchor.constraint(equalToConstant: 112),
            specialOffersView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            
            menuSectionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuSectionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuSectionsView.heightAnchor.constraint(equalToConstant: 48),
            menuSectionsView.topAnchor.constraint(equalTo: selectRegionButton.bottomAnchor, constant: 112 + 36),
            
            menuTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            menuTableView.topAnchor.constraint(equalTo: specialOffersView.bottomAnchor, constant: 32 + 48),
            menuTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // Set the content size of the scrollView based on the contentView's size
        let contentHeight = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: scrollView, attribute: .height, multiplier: 1.0, constant: CGFloat(200 * (menuElementsData.count - 2)))
        scrollView.addConstraint(contentHeight)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        scrollView.delegate = self
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        var menuSectionsViewFrame = menuSectionsView.frame
        let originalY = selectRegionButton.frame.maxY + max((specialOffersView.frame.maxY - yOffset), 0)
        let newY = max(originalY - yOffset, originalY)
        menuSectionsViewFrame.origin.y = newY
        menuSectionsView.frame = menuSectionsViewFrame
    }
}

// MARK: - MenuTableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    var tableViewCellID: String { "MenuElementTableViewCell" }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuElementsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID) as! MenuElementTableViewCell
        
        cell.setup(with: menuElementsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuElementsData.append(menuElementsData[menuElementsData.count - 3])
        menuTableView.reloadData()
    }
    
    func setupMenuTableView() {
        let nib = UINib(nibName: "MenuElementTableViewCell", bundle: nil)
        menuTableView.register(nib, forCellReuseIdentifier: tableViewCellID)
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.layer.cornerRadius = 20
        menuTableView.isScrollEnabled = false
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
        selectRegionButton.setTitle("Москва", for: .normal)
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


