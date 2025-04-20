//
//  CountrySearchViewModel.swift
//  CountriesApp
//
//  
//

import Foundation

final class CountriesViewModel {
    
    private let networkManager: NetworkService
    private var countries: [Country] = []
    private var filteredCountries: [Country] = []
    
    var isSearching: Bool = false
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func fetchCountries(completion: @escaping () -> Void) {
        let url = APIEndpoint.baseURL + APIEndpoint.path
        networkManager.fetchData(url: url) { [weak self] (result: Result<[Country], NetworkError>) in
            switch result {
            case .success(let countries):
                self?.countries = countries
                completion()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func filterCountries(for searchText: String) {
        filteredCountries = countries.filter { country in
            return country.name.lowercased().contains(searchText.lowercased()) ||
                   country.capital.lowercased().contains(searchText.lowercased())
        }
        isSearching = !searchText.isEmpty
    }
    
    func numberOfCountries() -> Int {
        return isSearching ? filteredCountries.count : countries.count
    }
    
    func country(at index: Int) -> Country {
        return isSearching ? filteredCountries[index] : countries[index]
    }
}
