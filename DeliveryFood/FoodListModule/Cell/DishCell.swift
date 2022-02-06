//
//  FoodCell.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import UIKit
import SDWebImage

class DishCell: UITableViewCell {
    
    // MARK: - Properties
    let dishImage = UIImageView()
    let stackView = UIStackView()
    let dishNameLabel = UILabel()
    let dishDescriptionLabel = UILabel()
    
    static let reuseID = "DishCell"
    static let rowHeight: CGFloat = 250
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    // MARK: - Configure method
    func configure(with dish: Dish) {
        dishImage.sd_setImage(with: dish.image)
        dishNameLabel.text = dish.name
        dishDescriptionLabel.text = dish.datumDescription
    }
}


extension DishCell {
    // MARK: - SetupViews
    private func setupViews() {
        dishImage.translatesAutoresizingMaskIntoConstraints = false
        dishImage.contentMode = .scaleAspectFill
        dishImage.layer.cornerRadius = 20
        dishImage.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        dishNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dishNameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        dishNameLabel.numberOfLines = 0
        dishNameLabel.textAlignment = .left
        dishNameLabel.adjustsFontSizeToFitWidth = true
        
        dishDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        dishDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dishDescriptionLabel.numberOfLines = 0
        dishDescriptionLabel.textAlignment = .left
        dishDescriptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Layout
    private func layout() {
        contentView.addSubview(dishImage)
        
        stackView.addArrangedSubview(dishNameLabel)
        stackView.addArrangedSubview(dishDescriptionLabel)
        contentView.addSubview(stackView)
        
        // dishImage constraint
        NSLayoutConstraint.activate([
            dishImage.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            dishImage.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor, multiplier: 2
            ),
            dishImage.heightAnchor.constraint(equalToConstant: 150),
            dishImage.widthAnchor.constraint(equalTo: dishImage.heightAnchor)
        ])
        
        // stackView constraint
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalToSystemSpacingBelow: topAnchor, multiplier: 2
            ),
            stackView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: dishImage.trailingAnchor,
                multiplier: 3
            ),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: stackView.trailingAnchor,
                multiplier: 2
            ),
            bottomAnchor.constraint(
                equalToSystemSpacingBelow: stackView.bottomAnchor,
                multiplier: 2
            )
        ])
    }
}
