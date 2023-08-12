//
//  WeatherEndpoint.swift
//  WeatherAppClone
//
//  Created by Dariga on 01.06.2023.
//

import Foundation

enum WeatherEndPoint {
    case forecast(cityName: String, days: Int)
}
extension WeatherEndPoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .forecast(let cityName, let days):
            guard let url = URL(string: Constants.apiHost + "forecast.json?key=\(Constants.apiKey)&q=\(cityName)&days=\(days)&aqi=no&alerts=no") else { fatalError() }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            return urlRequest
        }
    }
}
