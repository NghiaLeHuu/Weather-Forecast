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
        
        //Get hour data from JSON API
        if let time = hourlyDict["time"] as? Double{
            //Convert timestamp to the human date
            let convertDate = Date(timeIntervalSince1970: time)
            //Format the date
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            self.hour = dateFormatter.string(from: convertDate)
            print(self.hour)
        }
        //Get the weather type data from the JSON
        if let _summary = hourlyDict["summary"] as? String{
            self.summary = _summary
        }
        //Get the temp from the JSON
        if let _temp = hourlyDict["temperature"] as? Double{
            self.temp = ((_temp - 32)*5/9).rounded(toPlaces: 0)
        }
    }
}
