//
//  JsonParser.swift
//  SharkDevelopTestTask
//
//  Created by Nikita Elizarov on 10/04/2018.
//  Copyright © 2018 Nikita Elizarov. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonParser {
    
    func jsonToWeatherDataModel(json : JSON) -> WeatherDataModel {
        let weather = WeatherDataModel(temperature: fahrenheitToCelsius(temperature: json["currently"]["temperature"].doubleValue), city: "Novosibirsk", weatherIcon: json["currently"]["icon"].string!, summary: json["currently"]["summary"].stringValue)
        return weather
    }
    
    func jsonToWeatherForecastArray(json: JSON) -> [WeatherForecastDataModel] {
        let weeklyForecast = json["daily"]["data"]
        var weatherForecasts = [WeatherForecastDataModel]()
        for (index,subJson):(String, JSON) in weeklyForecast {
            // skip the current date
            if (index == "0"){
                continue
            }
            let dateString = unixTimeToString(unixTime: subJson["time"].doubleValue)
            let weatherForecastDay = WeatherForecastDataModel(lowestTemperature: fahrenheitToCelsius(temperature: subJson["temperatureMin"].doubleValue) , highestTemperature: fahrenheitToCelsius(temperature: subJson["temperatureMax"].doubleValue), time: dateString , weatherIcon: subJson["icon"].stringValue)
            weatherForecasts.append(weatherForecastDay)
        }
        return weatherForecasts
    }
    
    func unixTimeToString(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func fahrenheitToCelsius(temperature: Double) -> Int {
        let tempResult = Int (temperature - 32) * 5/9
        return tempResult
    }
    
}
