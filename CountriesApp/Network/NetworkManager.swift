//
//  NetworkManager.swift
//  CountriesApp
//
//  Created by  Neha Bisht on 04/02/25.
//

import Foundation

protocol NetworkService {
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

struct NetworkManager: NetworkService {
    func fetchData<T>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.invalidData))
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let dcodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(dcodedData))
            }catch{
                completion(.failure(.invalidJSON))
            }
            
        }
        task.resume()
    }
}
            
