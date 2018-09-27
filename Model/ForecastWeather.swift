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
        
        //Access to the JSON to get the data of date
        if let date = weatherDict["dt"] as? Double {
            //Convert date from timestamp to date to display
            let rawDate = Date(timeIntervalSince1970: date)
            //Adjust the format to display in the UI
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            self.date = "\(rawDate.dayOfTheWeek())"
        }
        
    }
    
}
