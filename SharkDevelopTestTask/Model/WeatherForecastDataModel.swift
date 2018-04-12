//
//  WeatherForecastDataModel.swift
//  SharkDevelopTestTask
//
//  Created by Nikita Elizarov on 06/04/2018.
//  Copyright © 2018 Nikita Elizarov. All rights reserved.
//

import Foundation

class WeatherForecastDataModel: NSObject, NSCoding {
    public var highestTemperature:Int
    public var lowestTemperature:Int
    public var time:String
    public var weatherIcon: String
    
    init(lowestTemperature: Int, highestTemperature: Int, time:String, weatherIcon:String) {
        self.highestTemperature = highestTemperature
        self.lowestTemperature = lowestTemperature
        self.time = time
        self.weatherIcon = weatherIcon
    }
    
    required init?(coder decoder: NSCoder) {
        self.highestTemperature = decoder.decodeInteger(forKey: "highestTemperature")
        self.lowestTemperature = decoder.decodeInteger(forKey: "lowestTemperature")
        self.time = decoder.decodeObject(forKey: "time") as! String
        self.weatherIcon = decoder.decodeObject(forKey: "weatherIcon") as! String
    }
    
     func encode(with aCoder: NSCoder) {
        aCoder.encode(weatherIcon, forKey: "weatherIcon")
        aCoder.encode(highestTemperature, forKey: "highestTemperature")
        aCoder.encode(lowestTemperature, forKey: "lowestTemperature")
        aCoder.encode(time, forKey: "time")
        
    }
    
}
