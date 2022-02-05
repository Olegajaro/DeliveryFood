//
//  NetworkService.swift
//  TestDeliveryApp
//
//  Created by Олег Федоров on 05.02.2022.
//

import Foundation

class NetworkService {
    typealias CompletionType = (Data?, Error?) -> Void
    
    func request(url: String, completion: @escaping CompletionType) {
        
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(
        from request: URLRequest,
        completion: @escaping CompletionType
    ) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
