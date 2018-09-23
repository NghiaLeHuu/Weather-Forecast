//
//  HourByHourWeather.swift
//  Weather Forecast
//
//  Created by Tuong on 9/23/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import Foundation

class HourByHourWeather{
    
    var hour:String!
    var summary:String! // weather type
    var temp:Double!
    
    init(hourlyDict: [String:Any]) {
        
        // get hour
        if let time = hourlyDict["time"] as? Double{
            
            print(time)
            let convertDate = Date(timeIntervalSince1970: time)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            self.hour = dateFormatter.string(from: convertDate)
            print(self.hour)
        }
        // get summary (weatherType)
        if let _summary = hourlyDict["summary"] as? String{
            self.summary = _summary
            print(self.summary)
        }
        
        // get temp (weatherType)
        if let _temp = hourlyDict["temperature"] as? Double{
            self.temp = ((_temp - 32)*5/9).rounded(toPlaces: 0)
            print(self.temp)
        }
    }
}
