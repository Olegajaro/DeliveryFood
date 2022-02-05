//
//  ImageManager.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation

class ImageManager {
    
    static func fetchImage(fromURL url: URL?) -> Data? {
        guard
            let url = url,
            let imageData = try? Data(contentsOf: url)
        else { return nil }
        
        return imageData
    }
}
