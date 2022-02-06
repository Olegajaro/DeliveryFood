//
//  Pizza.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation


protocol Dish {
    var name: String { get }
    var image: URL { get }
    var datumDescription: String { get }
}

// MARK: - Pizza
struct Pizza: Codable {
    let status: Int
    let message: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable, Dish {
    let id, name, datumDescription: String
    let image: URL
    let calories: Int
    let category: Category

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case image, calories, category
    }
}

enum Category: String, Codable {
    case cat2 = "cat2"
}
