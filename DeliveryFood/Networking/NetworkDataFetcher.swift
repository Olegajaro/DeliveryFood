//
//  NetworkDataFetcher.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService: NetworkService!
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchGenericJSONData<T: Codable>(
        url: String, response: @escaping (T?) -> Void
    ) {
        
        networkService.request(url: url) { data, error in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
    
    private func decodeJSON<T: Codable>(type: T.Type, from data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        
        guard let data = data else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
