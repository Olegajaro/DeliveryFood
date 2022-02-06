//
//  DishCellViewModel.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 06.02.2022.
//

import Foundation

protocol DishCellViewModelProtocol {
    var dishImageURL: URL { get }
    var dishName: String { get }
    var dishDescription: String { get }
}

struct DishCellViewModel: DishCellViewModelProtocol {
    
    var dishImageURL: URL {
        dish.image
    }
    var dishName: String {
        dish.name
    }
    
    var dishDescription: String {
        dish.datumDescription
    }
    
    private let dish: Dish
    
    init(dish: Dish) {
        self.dish = dish
    }
}
