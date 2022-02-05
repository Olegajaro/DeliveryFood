//
//  VegetarianDishes.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation

// MARK: - VegetarianDishes
struct VegetarianDishes: Codable {
    let status: Int
    let message: String
    let data: [Datum]
}

// MARK: - Datum
struct VegDatum: Codable {
    let id, name, datumDescription: String
    let image: String
    let calories: Int
    let category: VegCategory

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case image, calories, category
    }
}

enum VegCategory: String, Codable {
    case cat2 = "cat2"
}