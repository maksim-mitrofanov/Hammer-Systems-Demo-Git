//
//  MenuSectionsView.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 24.06.2023.
//

import UIKit

class MenuSectionsView: UIView  {
    private let reuseIdentifier = "MenuSectionCollectionViewCell"
    private var menuSectionCollectionView: UICollectionView!
    
    
    // Data + Delegate
    weak var dataSource: MenuSectionsViewDataSource?
    weak var delegate: MenuSectionsViewDelegate?
    var shouldReloadData: Bool = false {
        didSet {
            updateLayout()
        }
    }
    
    // Layout Values
    private let menuSectionCellWidth: CGFloat = 88
    private let menuSectionHorizontalSpacing: CGFloat = 8
    private let menuSectionTopSpacing: CGFloat = 24 
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMenuSectionCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMenuSectionCollectionView()
    }
}

// MARK: - Setup
private extension MenuSectionsView {
    func setupMenuSectionCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: menuSectionCellWidth, height: 32)
        layout.minimumLineSpacing = menuSectionHorizontalSpacing
        
        menuSectionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        menuSectionCollectionView.delegate = self
        menuSectionCollectionView.dataSource = self
        menuSectionCollectionView.register(MenuSectionCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        addSubview(menuSectionCollectionView)
        menuSectionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuSectionCollectionView.topAnchor.constraint(equalTo: topAnchor),
            menuSectionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuSectionCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuSectionCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        menuSectionCollectionView.showsHorizontalScrollIndicator = false
        menuSectionCollectionView.backgroundColor = UIColor(named: "MainColor")
    }
    
    func cellForMenuSectionCollection(collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuSectionCollectionViewCell
        
        guard let cellData = dataSource?.menuSectionData(at: indexPath) else { return cell }
        cell.setupWith(data: cellData)
        
        return cell
    }
    
    func updateLayout() {
        if shouldReloadData {
            menuSectionCollectionView.reloadData()
            shouldReloadData = false
        }
    }
}

extension MenuSectionsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMenuSection(at: indexPath)
    }
}

extension MenuSectionsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: menuSectionHorizontalSpacing * 2, bottom: 0, right:  menuSectionHorizontalSpacing * 2)
    }
}

extension MenuSectionsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource?.numberOfMenuSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForMenuSectionCollection(collectionView: collectionView, at: indexPath)
    }
}

// MARK: - Protocols
protocol MenuSectionsViewDelegate: AnyObject {
    func didSelectMenuSection(at indexPath: IndexPath)
}

protocol MenuSectionsViewDataSource: AnyObject {
    func menuSectionData(at indexPath: IndexPath) -> MenuSectionCellData
    func numberOfMenuSections() -> Int
}
