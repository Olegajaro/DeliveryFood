//
//  FoodListViewController.swift
//  DeliveryFood
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation

import UIKit

class FoodListViewController: UIViewController {
    
    // MARK: - Propeties
    let tableView = UITableView()
    var activityIndicator: UIActivityIndicatorView?
    
    var presenter: FoodListPresenterProtocol!
        
    // Set image for banners
    private let viewModel: FoodListHeaderViewModel = FoodListHeaderViewModel(
        viewModels: [
            BannerCollectionViewCellViewModel(image: UIImage(named: "banner1")!),
            BannerCollectionViewCellViewModel(image: UIImage(named: "banner2")!),
            BannerCollectionViewCellViewModel(image: UIImage(named: "banner3")!)
        ]
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupTableView()
        setupTableViewHeader()
        activityIndicator = showActivityIndicator(in: view)
    }
}

// MARK: - Setup Table View
extension FoodListViewController {
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DishCell.self,
                           forCellReuseIdentifier: DishCell.reuseID)
        tableView.register(FoodListSectionHeader.self,
                           forHeaderFooterViewReuseIdentifier: FoodListSectionHeader.identifier)
        tableView.rowHeight = DishCell.rowHeight
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
    
    private func setupTableViewHeader() {
        let header = FoodListHeaderView(frame: CGRect(
            x: 0, y: 0,
            width: view.frame.size.width,
            height: 150
        ))
        header.configure(with: viewModel)
        
        tableView.tableHeaderView = header
    }
    
    private func setupNavigationItem() {
        let barButtonItem = UIBarButtonItem(title: "Moscow  ⬇️")
        barButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = barButtonItem
    }
}

// MARK: - UITableViewDataSource
extension FoodListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let headerSection = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: FoodListSectionHeader.identifier
        ) as? FoodListSectionHeader
        headerSection?.delegate = self
        
        return headerSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.allDishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DishCell.reuseID,
            for: indexPath
        ) as! DishCell
        
        if let dish = presenter.allDishes?[indexPath.row] {
            cell.configure(with: dish)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension FoodListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - FoodListViewProtocol
extension FoodListViewController: FoodListViewProtocol {
    func success() {
        tableView.reloadData()
        activityIndicator?.stopAnimating()
    }
}

// MARK: - FoodListSectionHeaderDelegate
extension FoodListViewController: FoodListSectionHeaderDelegate {
    func handleActionForPizzaCategoryButton(for controller: FoodListViewController) {
        let selectedRows = controller.tableView.indexPathsForSelectedRows
        if let selectedRow = selectedRows?[10] {
            controller.tableView.scrollToRow(at: selectedRow, at: .middle, animated: true)
        }
        print("DEBUG: pizza")
        
        controller.tableView.isHidden = true
    }
}
