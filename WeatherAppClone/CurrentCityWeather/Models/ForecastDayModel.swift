//
//  ForecastDayModel.swift
//  WeatherAppClone
//
//  Created by Dariga on 01.06.2023.
//

import Foundation

struct ForecastDayModel: Decodable {
    let date: String
    let day: ForecastDayDayModel
    let hour: [ForecastHourModel]
}

struct ForecastDayDayModel: Decodable {
    let maxTemperature: Double
    let minTemperature: Double
    let condition: WeatherConditionModel
    
    enum CodingKeys: String, CodingKey{
        case maxTemperature = "maxtemp_c"
        case minTemperature = "mintemp_c"
        case condition
    }
}

struct ForecastHourModel: Decodable {
    let time: String
    let currentTemperature: Double
    let condition: WeatherConditionModel
    
    enum CodingKeys: String, CodingKey {
        case time
        case currentTemperature = "temp_c"
        case condition
    }
}

