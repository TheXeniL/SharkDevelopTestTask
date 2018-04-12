//
//  WeatherConditionIconManager.swift
//  SharkDevelopTestTask
//
//  Created by Nikita Elizarov on 12/04/2018.
//  Copyright © 2018 Nikita Elizarov. All rights reserved.
//

import Foundation
class WeatherConditionIconManager {
    
    static func updateWeatherIcon(condition: String) -> String {
        switch (condition) {
        case "clear-day":
            return "sunny"
        case "clear-night":
            return "sunny-night"
        case "partly-cloudy-night":
            return "cloudy4_night"
        case "partly-cloudy-day":
            return "cloudy4"
        case "rain":
            return "light_rain"
        case "snow" :
            return "snow5"
        case "wind" :
            return "overcast"
        case "cloudy":
            return "cloudy5"
        case "fog":
            return "fog"
        default:
            return "dunno"
        }
    }
}
