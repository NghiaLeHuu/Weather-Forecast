//
//  ForecastWeather.swift
//  Weather Forecast
//
//  Created by Doan The Dang Khoa on 9/19/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import Foundation

class ForecastWeather{
    var date:String!
    var temp:Double!
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let dayTemp = temp["day"] as? Double {
                let rawValue = (dayTemp - 273.15).rounded(toPlaces: 0)
                self.temp = rawValue
            }
        }
        if let date = weatherDict["dt"] as? Double {
            
            let rawDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            self.date = "\(rawDate.dayOfTheWeek())"
        }
        
    }
    
}
