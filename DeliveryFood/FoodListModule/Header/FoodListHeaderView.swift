//
//  FoodListHeaderView.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import UIKit

struct FoodListHeaderViewModel {
    let viewModels: [BannerCollectionViewCellViewModel]
}

class FoodListHeaderView: UIView {
    
    // MARK: - Properties
    let containerView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            BannerCollectionViewCell.self,
            forCellWithReuseIdentifier: BannerCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private var viewModels: [BannerCollectionViewCellViewModel] = []
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with viewModel: FoodListHeaderViewModel) {
        self.viewModels = viewModel.viewModels
    }
}

// MARK: - SetupViews, Layout
extension FoodListHeaderView {
    private func setupViews() {
        backgroundColor = .systemBackground
        addSubview(containerView)
        containerView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func layout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(
                equalTo: collectionView.widthAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            ),
            collectionView.heightAnchor.constraint(
                equalTo: containerView.heightAnchor
            )
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension FoodListHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCollectionViewCell.identifier,
            for: indexPath
        ) as! BannerCollectionViewCell
        
        let banner = viewModels[indexPath.row]
        cell.configure(with: banner)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FoodListHeaderView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
}

