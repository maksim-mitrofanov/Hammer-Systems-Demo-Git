//
//  MenuViewController.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 23.06.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
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
    
    var bannersData = MenuDataModel.getBannersData()
    var menuSectionsData = MenuDataModel.getMenuSectionsData()
    var menuElementsData = MenuDataModel.getMenuElementsData()
}


// MARK: - ScrollView
extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        var menuSectionsViewFrame = menuSectionsView.frame
        let originalY = selectRegionButton.frame.maxY + max((specialOffersView.frame.maxY - yOffset), 0)
        var newY = max(originalY - yOffset / 12, originalY)
        
        // Needs updates
        if yOffset < 136  {
            newY += 12
        }

        print("Offset: \(yOffset), newY: \(newY)")
        
        menuSectionsViewFrame.origin.y = newY
        menuSectionsView.frame = menuSectionsViewFrame
    }
    
    func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        scrollView.delegate = self
    }
}

// MARK: - MenuTableView
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    var tableViewCellID: String { "MenuElementTableViewCell" }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuElementsData.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = Section.allCases[section]
        return menuElementsData[currentSection]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID) as! MenuElementTableViewCell
        
        let currentSection = Section.allCases[indexPath.section]
        if let elementsInSection = menuElementsData[currentSection] {
            cell.setup(with: elementsInSection[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentSection = Section.allCases[section]
        switch currentSection {
        case .pizza:
            return "Pizza"
        case .combo:
            return "Combo"
        case .deserts:
            return "Desserts"
        case .drinks:
            return "Drinks"
        }
    }
    
    func setupMenuTableView() {
        let nib = UINib(nibName: "MenuElementTableViewCell", bundle: nil)
        menuTableView.register(nib, forCellReuseIdentifier: tableViewCellID)
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.layer.cornerRadius = 20
    }
}

// MARK: - SpecialOffersView
extension MenuViewController: SpecialOffersViewDelegate, SpecialOffersViewDataSource {
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
extension MenuViewController: MenuSectionsViewDelegate, MenuSectionsViewDataSource {
    private func setupMenuSectionsView() {
        menuSectionsView.backgroundColor = .clear
        menuSectionsView.dataSource = self
        menuSectionsView.delegate = self
    }
    
    func didSelectMenuSection(at indexPath: IndexPath) {
        menuSectionsData.indices.forEach { menuSectionsData[$0].isActive = false }
        menuSectionsData[indexPath.row].isActive = true
        menuSectionsView.shouldReloadData = true
        
        scrollView.isScrollEnabled = false
        menuTableView.isScrollEnabled = true
        
 
        let destinationIndexPath = IndexPath(row: 0, section: 3)
        
        menuTableView.scrollToRow(at: destinationIndexPath, at: .bottom, animated: true)
        
        scrollView.isScrollEnabled = true
        menuTableView.isScrollEnabled = false
    }
    
    func numberOfMenuSections() -> Int {
        menuSectionsData.count
    }
    
    func menuSectionData(at indexPath: IndexPath) -> MenuSectionCellData {
        menuSectionsData[indexPath.row]
    }
}

// MARK: - SelectRegionButton
private extension MenuViewController {
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

// MARK: - UI Setup
private extension MenuViewController {
    func setupUI() {
        instantiateAllViews()
        updateConstraintsMode()
        addCustomViewsAsSubviews()
        setupAllViews()
        setupLayoutConstraints()
    }
    
    func instantiateAllViews() {
        scrollView = UIScrollView()
        contentView = UIView()
        selectRegionButton = UIButton()
        specialOffersView = SpecialOffersView()
        menuSectionsView = MenuSectionsView()
        menuTableView = UITableView()
    }
    
    func updateConstraintsMode() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        selectRegionButton.translatesAutoresizingMaskIntoConstraints = false
        specialOffersView.translatesAutoresizingMaskIntoConstraints = false
        menuSectionsView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addCustomViewsAsSubviews() {
        view.addSubview(selectRegionButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(specialOffersView)
        view.addSubview(menuSectionsView)
        contentView.addSubview(menuTableView)
    }
    
    func setupAllViews() {
        setupRegionsButton()
        setupOffersView()
        setupMenuSectionsView()
        setupMenuTableView()
        setupScrollView()
    }
    
    func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            
            // Pin selectRegionButton
            selectRegionButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: selectRegionButtonTopConstraint),
            selectRegionButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: selectRegionButtonLeadingConstraint),
            
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
            
            specialOffersView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            specialOffersView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            specialOffersView.heightAnchor.constraint(
                equalToConstant: specialOffersViewHeightConstraint),
            specialOffersView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: specialOffersViewTopConstraint),
            
            // Pin menuSectionsView to the bottom of selectRegionButton
            menuSectionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuSectionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuSectionsView.heightAnchor.constraint(
                equalToConstant: menuSectionsViewHeightConstraint),
            menuSectionsView.topAnchor.constraint(
                equalTo: selectRegionButton.bottomAnchor,
                constant: menuSectionsViewTopConstraint),
            
            menuTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            menuTableView.topAnchor.constraint(equalTo: specialOffersView.bottomAnchor, constant: menuTableViewTopConstraint),
            menuTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let contentHeight = NSLayoutConstraint(item: contentView as Any, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: scrollView, attribute: .height, multiplier: 1.0, constant: CGFloat(200 * (menuElementsData.flatMap { $0.value }.count - 2)))
        scrollView.addConstraint(contentHeight)
    }
    
    // Values
    var selectRegionButtonTopConstraint: CGFloat { 16 }
    var selectRegionButtonLeadingConstraint: CGFloat { 16 }
    var specialOffersViewHeightConstraint: CGFloat { 112 }
    var specialOffersViewTopConstraint: CGFloat { 24 }
    var menuSectionsViewHeightConstraint: CGFloat { 56 }
    var menuSectionsViewTopConstraint: CGFloat { specialOffersViewHeightConstraint + 36 }
    var menuTableViewTopConstraint: CGFloat { 80 }
}

