//
//  SearchCityDataSource.swift
//  WeatherAppClone
//
//  Created by Dariga on 12.08.2023.
//

import Foundation

class SearchCityDataSource {
    private let network = Network()
    
    func searchCity(query: String, completion: @escaping (Result<[SearchCityModel], Error>) -> Void) {
        network.execute(SearchCityEndPoint.search(query: query), completion: completion)
    }
}
