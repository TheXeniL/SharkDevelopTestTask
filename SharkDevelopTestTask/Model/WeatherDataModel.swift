//
//  Weather.swift
//  SharkDevelopTestTask
//
//  Created by Nikita Elizarov on 05/04/2018.
//  Copyright © 2018 Nikita Elizarov. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataModel: NSObject, NSCoding {

    
    public var temperature: Int
    public var city: String
    public var weatherIcon: String
    public var summary: String
    
    init(temperature: Int, city: String, weatherIcon: String, summary: String) {
        self.temperature = temperature
        self.city = city
        self.weatherIcon = weatherIcon
        self.summary = summary
    }
    
    required init?(coder decoder: NSCoder) {
        self.temperature = decoder.decodeInteger(forKey: "temperature")
        self.city = decoder.decodeObject(forKey: "city") as! String
        self.weatherIcon = decoder.decodeObject(forKey: "weatherIcon") as! String
        self.summary = decoder.decodeObject(forKey: "summary") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(temperature, forKey: "temperature")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(weatherIcon, forKey: "weatherIcon")
        aCoder.encode(summary, forKey: "summary")
    }
    
}
