//
//  BannerCollectionViewCell.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import UIKit

struct BannerCollectionViewCellViewModel {
    let image: UIImage
}

class BannerCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "collectionCell"
    
    var imageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemBackground
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    // MARK: - Configure method
    func configure(with viewModel: BannerCollectionViewCellViewModel) {
        imageView.image = viewModel.image
    }
}
