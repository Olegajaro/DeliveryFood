//
//  FoodListSectionHeader.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 06.02.2022.
//

import UIKit

protocol FoodListSectionHeaderDelegate: AnyObject {
    func handleActionForPizzaCategoryButton()
    func handleActionForVegiCategoryButton()
    func handleActionForSeaFoodCategoryButton()
}

class FoodListSectionHeader: UITableViewHeaderFooterView {
    // MARK: - Properties
    static let identifier = "FoodListSectionHeader"
    
    let stackView = UIStackView()
    let pizzaCategoryButton = UIButton(type: .system)
    let vegiCategoryButton = UIButton(type: .system)
    let seaFoodCategoryButton = UIButton(type: .system)
    
    private let buttonHeight: CGFloat = 30
    weak var delegate: FoodListSectionHeaderDelegate?
    
    // MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
}

extension FoodListSectionHeader {
    // MARK: - SetupViews()
    private func setupViews() {
        contentView.backgroundColor = appColor
        
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
        pizzaCategoryButton.addTarget(
            self,
            action: #selector(didTapPizzaCategoryButton),
            for: .touchUpInside
        )
        
        vegiCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        vegiCategoryButton.setTitle("Vegetarian", for: .normal)
        vegiCategoryButton.setTitleColor(.white, for: .normal)
        vegiCategoryButton.backgroundColor = .lightGray
        vegiCategoryButton.layer.cornerRadius = buttonHeight / 2
        vegiCategoryButton.addTarget(
            self,
            action: #selector(didTapVegiCategoryButton),
            for: .touchUpInside
        )
        
        seaFoodCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        seaFoodCategoryButton.setTitle("Sea Food", for: .normal)
        seaFoodCategoryButton.setTitleColor(.white, for: .normal)
        seaFoodCategoryButton.backgroundColor = .lightGray
        seaFoodCategoryButton.layer.cornerRadius = buttonHeight / 2
        seaFoodCategoryButton.addTarget(
            self,
            action: #selector(didTapSeaFoodCategoryButton),
            for: .touchUpInside
        )
    }
    
    // MARK: - Layout
    private func layout() {
        // stackView constraints
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
        
        // buttons constaints
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
}

// MARK: - Actions
extension FoodListSectionHeader {
    @objc func didTapPizzaCategoryButton() {
        delegate?.handleActionForPizzaCategoryButton()
    }
    
    @objc func didTapVegiCategoryButton() {
        delegate?.handleActionForVegiCategoryButton()
    }
    
    @objc func didTapSeaFoodCategoryButton() {
        delegate?.handleActionForSeaFoodCategoryButton()
    }
}


