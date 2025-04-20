//
//  CountriesAppTests.swift
//  CountriesAppTests
//
//   Created by  Neha Bisht on 04/02/25.
//

import XCTest
@testable import CountriesApp

final class CountriesAppTests: XCTestCase {
    var viewModel: CountriesViewModel!
    var dummyNetworkManager: DummyNetworkManager!
    
    override func setUp() {
           super.setUp()
           dummyNetworkManager = DummyNetworkManager()
           viewModel = CountriesViewModel(networkManager: dummyNetworkManager)
       }
    
    override func tearDown() {
            viewModel = nil
            dummyNetworkManager = nil
            super.tearDown()
        }
    
    func testFetchCountries_success() {
        // Given
        dummyNetworkManager.fileName = "DummyCountriesData"
        let expectation = XCTestExpectation(description: "Fetch countries successfully")
        
        // When
        viewModel.fetchCountries {
            // Then
            XCTAssertEqual(self.viewModel.numberOfCountries(), 2)
            XCTAssertEqual(self.viewModel.country(at: 0).name, "Afghanistan")
            XCTAssertEqual(self.viewModel.country(at: 1).name, "Albania")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
       
    
    func testFilterCountries() {
        // Given
        dummyNetworkManager.fileName = "DummyCountriesData"
        let expectation = XCTestExpectation(description: "Filter countries")
        
        // When
        viewModel.fetchCountries {
            self.viewModel.filterCountries(for: "Afghanistan")
            
            // Then
            XCTAssertEqual(self.viewModel.numberOfCountries(), 1)
            XCTAssertEqual(self.viewModel.country(at: 0).name, "Afghanistan")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFilterCountries_noResults() {
        // Given
        dummyNetworkManager.fileName = "DummyCountriesData"
        let expectation = XCTestExpectation(description: "Filter countries with no results")
        
        // When
        viewModel.fetchCountries {
            self.viewModel.filterCountries(for: "InvalidCountry")
            
            // Then
            XCTAssertEqual(self.viewModel.numberOfCountries(), 0) // No results should match
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
