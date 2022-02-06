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
    var allDishes: [AllDishes]? { get set }
    init(view: FoodListViewController, dataFetcherService: DataFetcherService)
    func fetchData()
}

class FoodListPresenter: FoodListPresenterProtocol {
    weak var view: FoodListViewController?
    let dataFetcherService: DataFetcherService!
    
    var allDishes: [AllDishes]?
    
    private var pizzas: Pizza?
    private var vegiFoods: VegetarianDishes?
    private var seaFoods: SeaFood?
    
    required init(view: FoodListViewController,
                  dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService
        fetchData()
    }
    
    func fetchData() {
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
            self.view?.success()
        }
    }
}
