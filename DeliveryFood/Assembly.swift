//
//  Assembly.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 06.02.2022.
//

import UIKit

protocol AssemblyProtocol {
    func createFoodListModule() -> UIViewController
}

class Assembly: AssemblyProtocol {
    func createFoodListModule() -> UIViewController {
        let view = FoodListViewController()
        let dataFetcherService = DataFetcherService()
        let presenter = FoodListPresenter(view: view,
                                          dataFetcherService: dataFetcherService)
        
        view.presenter = presenter
        return view
    }
}
