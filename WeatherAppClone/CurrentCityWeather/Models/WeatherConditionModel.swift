//
//  WeatherConditionModel.swift
//  WeatherAppClone
//
//  Created by Dariga on 01.06.2023.
//

import Foundation

struct WeatherConditionModel: Decodable {
    let text: String
    let iconURLPath: String
    
    enum CodingKeys: String, CodingKey {
        case text
        case iconURLPath = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        let iconPath = try container.decode(String.self, forKey: .iconURLPath)
        self.iconURLPath = "https:" + iconPath
    }
}
