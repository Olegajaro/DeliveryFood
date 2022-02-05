//
//  DataFetcherService.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation

let pizzasURL = "https://yummie.glitch.me//dishes/cat2"
let vegiURL = "https://yummie.glitch.me//dishes/cat5"
let seaFoodURL = "https://yummie.glitch.me//dishes/cat4"


class DataFetcherService {
    
    var networkDataFetcher: NetworkDataFetcher!
    
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchPizzas(completion: @escaping (Pizza?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(
            url: pizzasURL,
            response: completion
        )
    }
    
    func fetchVegiDishes(completion: @escaping (VegetarianDishes?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(
            url: vegiURL,
            response: completion
        )
    }
    
    func fetchSeaFoods(completion: @escaping (SeaFood?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(
            url: seaFoodURL,
            response: completion
        )
    }
}
