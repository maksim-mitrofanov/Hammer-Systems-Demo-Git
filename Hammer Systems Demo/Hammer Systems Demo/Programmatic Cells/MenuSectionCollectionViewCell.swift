//
//  MenuSectionCollectionViewCell.swift
//  Hammer Systems Demo
//
//  Created by Максим Митрофанов on 23.06.2023.
//

import UIKit

class MenuSectionCollectionViewCell: UICollectionViewCell {
    
    func setupWith(data: MenuSectionCellData) {
        displayedTitle = data.title
        isActive = data.isActive
        setupCellAppearance()
    }
    
    // Layout
    private var displayedTitle: String = ""
    private var isActive: Bool = false
    
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCellAppearance()
    }
}

private extension MenuSectionCollectionViewCell {
    // Values
    var accentColor: UIColor { UIColor(named: "AccentColor")! }
    var labelTextColor: UIColor { accentColor.withAlphaComponent(isActive ? 1 : 0.4) }
    var labelTextFont: UIFont { UIFont.systemFont(ofSize: 13, weight: isActive ? .bold : .medium) }
    var rectangleFillColor: UIColor { isActive ? accentColor.withAlphaComponent(0.2) : .clear }
    var rectangleBorderColor: UIColor { isActive ? .clear : accentColor.withAlphaComponent(0.4) }
    
    func setupCellAppearance() {
        subviews.forEach { $0.removeFromSuperview() }
        
        let roundedRectangleView = createRoundedRectView()
        addSubview(roundedRectangleView)
        setConstraintsFor(rectangle: roundedRectangleView)
        
        let label = createLabelView()
        roundedRectangleView.addSubview(label)
        setConstraintsFor(label: label, rect: roundedRectangleView)
    }
}

private extension MenuSectionCollectionViewCell {
    
    // Label
    func createLabelView() -> UIView {
        let label = UILabel()
        label.text = displayedTitle
        label.font = labelTextFont
        label.textColor = labelTextColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }
    
    func setConstraintsFor(label: UIView, rect: UIView) {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: rect.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: rect.centerYAnchor)
        ])
    }
    
    // Background Rectangle
    func createRoundedRectView() -> UIView {
        let roundedRectangleView = UIView()
        roundedRectangleView.backgroundColor = rectangleFillColor
        roundedRectangleView.translatesAutoresizingMaskIntoConstraints = false
        roundedRectangleView.layer.cornerRadius = bounds.height / 2
        
        roundedRectangleView.layer.borderColor = rectangleBorderColor.cgColor
        roundedRectangleView.layer.borderWidth = isActive ? 0 : 1
        
        return roundedRectangleView
    }
    
    func setConstraintsFor(rectangle: UIView) {
        NSLayoutConstraint.activate([
            rectangle.centerXAnchor.constraint(equalTo: centerXAnchor),
            rectangle.centerYAnchor.constraint(equalTo: centerYAnchor),
            rectangle.heightAnchor.constraint(equalToConstant: bounds.height),
            rectangle.widthAnchor.constraint(equalToConstant: bounds.width)
        ])
    }
}
