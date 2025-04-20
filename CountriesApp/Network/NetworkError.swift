//
//  NetworkError.swift
//  CountriesApp
//
//   Created by  Neha Bisht on 04/02/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case invalidJSON
    case invalidHTTPStatusCode
    case parsingError
    case dataNotFound
    case invalidHTTPMethod
    case decodingError
}
