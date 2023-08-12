//
//  SearchCityEndPoint.swift
//  WeatherAppClone
//
//  Created by Dariga on 12.08.2023.
//

import Foundation

enum SearchCityEndPoint {
    case search(query: String)
}

extension SearchCityEndPoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .search(let query):
            guard let url = URL(string: Constants.apiHost + "search.json?key=\(Constants.apiKey)&q=\(query)&aqi=no") else { fatalError() }
            
            let urlRequest = URLRequest(url: url)
            return urlRequest
        }
    }
}
