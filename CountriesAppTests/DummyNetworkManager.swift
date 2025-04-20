//
//  DummyNetworkManager.swift
//  CountriesApp
//
//   Created by  Neha Bisht on 04/02/25.
//

import Foundation
@testable import CountriesApp

class DummyNetworkManager: NetworkService {
    var fileName = ""
    
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let bundle = Bundle(for: DummyNetworkManager.self)
        guard let urlObj = bundle.url(forResource: fileName, withExtension: "json") else {
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            let data = try Data(contentsOf: urlObj)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.decodingError))
        }
    }
}
