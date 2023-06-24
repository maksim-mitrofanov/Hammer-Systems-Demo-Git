//
//  SpecialOfferCollectionViewCell.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 23.06.2023.
//

import UIKit

class SpecialOfferCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellAppearance()
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCellAppearance()
        setupImageView()
    }
    
    var displayedImageName: String = "Default Gradient" {
        didSet {
            imageView.image = UIImage(named: displayedImageName)
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
}

// Layout
private extension SpecialOfferCollectionViewCell {
    
    private func setupCellAppearance() {
        imageView.image = UIImage(named: "demo image")
        imageView.layer.cornerRadius = 10
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

