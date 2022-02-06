//
//  FoodListPresenter.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 06.02.2022.
//

import Foundation

protocol FoodListViewProtocol: AnyObject {
    func success()
}

protocol FoodListPresenterProtocol: AnyObject {
    init(view: FoodListViewController, dataFetcherService: DataFetcherService)
    func fetchData()
    func numberOfRows() -> Int
    func dishCellViewModel(
        forIndexPath indexPath: IndexPath
    ) -> DishCellViewModelProtocol?
}

class FoodListPresenter: FoodListPresenterProtocol {
    weak var view: FoodListViewController?
    let dataFetcherService: DataFetcherService!
    
    private var allDishes: [Dish]?
    
    private var pizzas: Pizza?
    private var vegiFoods: VegetarianDish?
    private var seaFoods: SeaFood?
    
    required init(view: FoodListViewController,
                  dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService
        fetchData()
    }
    
    func fetchData() {
        let group = DispatchGroup()
        
        fetchPizzas(group: group)
        fetchVegiDishes(group: group)
        fetchSeaFoods(group: group)

        group.notify(queue: .main) {
            self.notifyAction()
        }
    }
    
    func numberOfRows() -> Int {
        allDishes?.count ?? 0
    }
    
    
    func dishCellViewModel(
        forIndexPath indexPath: IndexPath
    ) -> DishCellViewModelProtocol? {
        if let dish = allDishes?[indexPath.row] {
            return DishCellViewModel(dish: dish)
        }
        
        return nil
    }
    
    private func fetchPizzas(group: DispatchGroup) {
        group.enter()
        dataFetcherService.fetchPizzas { [weak self] pizzas in
            self?.pizzas = pizzas
            group.leave()
        }
    }
    
    private func fetchVegiDishes(group: DispatchGroup) {
        group.enter()
        dataFetcherService.fetchVegiDishes { [weak self] vegiFoods in
            self?.vegiFoods = vegiFoods
            group.leave()
        }
    }
    
    private func fetchSeaFoods(group: DispatchGroup) {
        group.enter()
        dataFetcherService.fetchSeaFoods { [weak self] seaFoods in
            self?.seaFoods = seaFoods
            group.leave()
        }
    }
    
    private func notifyAction() {
        guard
            let pizzaData = self.pizzas?.data,
            let vegiData = self.vegiFoods?.data,
            let seaFoodData = self.seaFoods?.data
        else { return }
        
        self.allDishes = pizzaData + vegiData + seaFoodData
        self.view?.success()
    }
}
