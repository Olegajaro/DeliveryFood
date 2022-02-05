//
//  SeaFood.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation

// MARK: - SeaFood
struct SeaFood: Codable {
    let status: Int
    let message: String
    let data: [Datum]
}

// MARK: - Datum
struct SeaDatum: Codable {
    let id, name, datumDescription: String
    let image: String
    let calories: Int
    let category: SeaCategory

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case image, calories, category
    }
}

enum SeaCategory: String, Codable {
    case cat4 = "cat4"
}
