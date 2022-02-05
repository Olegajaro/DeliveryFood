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
    let numbers = [1, 2, 3, 4]
    
    let dataFetcherService = DataFetcherService()
    
    var allDishes: [AllDishes]?
    
    var pizzas: Pizza?
    var vegiFoods: VegetarianDishes?
    var seaFoods: SeaFood?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
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
}

// MARK: - UITableViewDataSource
extension FoodListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        allDishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellID,
            for: indexPath
        )
        
        var content = cell.defaultContentConfiguration()
        content.text = allDishes?[indexPath.row].name
        
        cell.contentConfiguration = content
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
