//
//  FoodListViewController.swift
//  DeliveryFood
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation

import UIKit

private let cellID = "Cell"

class FoodListViewController: UIViewController {
    
    let tableView = UITableView()
    
    let dataFetcherService = DataFetcherService()
    
    var allDishes: [AllDishes]?
    
    var pizzas: Pizza?
    var vegiFoods: VegetarianDishes?
    var seaFoods: SeaFood?
    
    private let viewModel: FoodListHeaderViewModel = FoodListHeaderViewModel(
        viewModels: [
            BannerCollectionViewCellViewModel(image: UIImage(named: "banner1")!),
            BannerCollectionViewCellViewModel(image: UIImage(named: "banner2")!),
            BannerCollectionViewCellViewModel(image: UIImage(named: "banner3")!)
        ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTableViewHeader()
        fetchData()
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        dataFetcherService.fetchPizzas { pizzas in
            self.pizzas = pizzas
            group.leave()
        }
        
        group.enter()
        dataFetcherService.fetchVegiDishes { vegiFoods in
            self.vegiFoods = vegiFoods
            group.leave()
        }
        
        group.enter()
        dataFetcherService.fetchSeaFoods { seaFoods in
            self.seaFoods = seaFoods
            group.leave()
        }
        
        group.notify(queue: .main) {
            guard
                let pizzaData = self.pizzas?.data,
                let vegiData = self.vegiFoods?.data,
                let seaFoodData = self.seaFoods?.data
            else { return }
            
            self.allDishes = pizzaData + vegiData + seaFoodData
            self.tableView.reloadData()
        }
    }
}

// MARK: - Setup Table View
extension FoodListViewController {
    private func setup() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DishCell.self,
                           forCellReuseIdentifier: DishCell.reuseID)
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
}

// MARK: - UITableViewDataSource
extension FoodListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        "Dishes"
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        allDishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DishCell.reuseID,
            for: indexPath
        ) as! DishCell
        
        if let dish = allDishes?[indexPath.row] {
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
