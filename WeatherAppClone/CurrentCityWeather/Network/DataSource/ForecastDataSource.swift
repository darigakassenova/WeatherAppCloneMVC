//
//  ForecastDataSource.swift
//  WeatherAppClone
//
//  Created by Dariga on 01.06.2023.
//

import Foundation

class ForecastDataSource {
    private let network = Network()
    
    func getForecast(cityName: String, days: Int, completion: @escaping (Result<CityModel, Error>) -> Void) {
        network.execute(WeatherEndPoint.forecast(cityName: cityName, days: days), completion: completion)
    }
}
