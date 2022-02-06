//
//  FoodListSectionHeader.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 06.02.2022.
//

import UIKit

class FoodListSectionHeader: UITableViewHeaderFooterView {
    static let identifier = "FoodListSectionHeader"
    
    let stackView = UIStackView()
    let pizzaCategoryButton = UIButton(type: .system)
    let vegiCategoryButton = UIButton(type: .system)
    let seaFoodCategoryButton = UIButton(type: .system)
    
    private let buttonHeight: CGFloat = 30
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 2
            ),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: stackView.trailingAnchor,
                multiplier: 2
            )
        ])
        
        NSLayoutConstraint.activate([
            pizzaCategoryButton.heightAnchor.constraint(
                equalToConstant: buttonHeight
            ),
            vegiCategoryButton.heightAnchor.constraint(
                equalToConstant: buttonHeight
            ),
            seaFoodCategoryButton.heightAnchor.constraint(
                equalToConstant: buttonHeight
            )
        ])
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(pizzaCategoryButton)
        stackView.addArrangedSubview(vegiCategoryButton)
        stackView.addArrangedSubview(seaFoodCategoryButton)
        
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        pizzaCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        pizzaCategoryButton.setTitle("Pizza", for: .normal)
        pizzaCategoryButton.setTitleColor(.white, for: .normal)
        pizzaCategoryButton.backgroundColor = .lightGray
        pizzaCategoryButton.layer.cornerRadius = buttonHeight / 2
        
        vegiCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        vegiCategoryButton.setTitle("Vegetarian", for: .normal)
        vegiCategoryButton.setTitleColor(.white, for: .normal)
        vegiCategoryButton.backgroundColor = .lightGray
        vegiCategoryButton.layer.cornerRadius = buttonHeight / 2
        
        seaFoodCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        seaFoodCategoryButton.setTitle("Sea Food", for: .normal)
        seaFoodCategoryButton.setTitleColor(.white, for: .normal)
        seaFoodCategoryButton.backgroundColor = .lightGray
        seaFoodCategoryButton.layer.cornerRadius = buttonHeight / 2
    }
}


