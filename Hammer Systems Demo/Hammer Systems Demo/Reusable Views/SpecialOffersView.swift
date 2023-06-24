//
//  OffersCollectionViewController.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 24.06.2023.
//

import UIKit

class SpecialOffersView: UIView {
    private let reuseIdentifier = "SpecialOfferCollectionViewCell"
    private var specialOffersCollectionView: UICollectionView!
    
    
    // Data + Delegate
    weak var dataSource: SpecialOffersViewDataSource?
    weak var delegate: SpecialOffersViewDelegate?
    var shouldReloadData: Bool = false {
        didSet {
            updateLayout()
        }
    }
    
    // Layout Values
    private let offersCellWidth: CGFloat = 300
    private let offersCollectionHorizontalSpacing: CGFloat = 16
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOffersCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupOffersCollectionView()
    }
}

extension SpecialOffersView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - Layout functions
    private func setupOffersCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: offersCellWidth, height: 112)
        layout.minimumLineSpacing = offersCollectionHorizontalSpacing
        
        specialOffersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        specialOffersCollectionView.delegate = self
        specialOffersCollectionView.dataSource = self
        specialOffersCollectionView.register(SpecialOfferCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        addSubview(specialOffersCollectionView)
        specialOffersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            specialOffersCollectionView.topAnchor.constraint(equalTo: topAnchor),
            specialOffersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            specialOffersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            specialOffersCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        specialOffersCollectionView.showsHorizontalScrollIndicator = false
        specialOffersCollectionView.backgroundColor = .clear
    }
    
    private func cellForOffersCollectionView(collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SpecialOfferCollectionViewCell
        
        guard let cellImageName = dataSource?.imageNameForCell(at: indexPath)
        else { return cell }
        
        cell.displayedImageName = cellImageName
        
        return cell
    }
    
    private func updateLayout() {
        if shouldReloadData {
            specialOffersCollectionView.reloadData()
            shouldReloadData = false
        }
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapElement(at: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: offersCollectionHorizontalSpacing, bottom: 0, right: offersCollectionHorizontalSpacing)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource?.numberOfElements() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForOffersCollectionView(collectionView: collectionView, at: indexPath)
    }
}


// MARK: - Protocols
protocol SpecialOffersViewDelegate: AnyObject {
    func didTapElement(at indexPath: IndexPath)
}

protocol SpecialOffersViewDataSource: AnyObject {
    func imageNameForCell(at indexPath: IndexPath) -> String
    func numberOfElements() -> Int
}
