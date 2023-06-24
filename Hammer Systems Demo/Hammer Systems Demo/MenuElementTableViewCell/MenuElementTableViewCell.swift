//
//  MenuElementTableViewCell.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 23.06.2023.
//

import UIKit

class MenuElementTableViewCell: UITableViewCell {

    @IBOutlet private weak var displayedImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var priceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupAppearance() {
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = UIColor(named: "AccentColor")!.cgColor
        priceButton.layer.cornerRadius = 6
        displayedImage.layer.cornerRadius = displayedImage.frame.height / 2
    }
        
    func setup(with data: MenuElementData) {
        displayedImage.image = UIImage(named: data.imageName)!
        titleLabel.text = data.title
        descriptionLabel.text = data.subtitle
        priceButton.setTitle(data.price, for: .normal)
    }
}
