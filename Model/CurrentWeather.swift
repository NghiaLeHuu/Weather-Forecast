//
//  CurrentWeather.swift
//  Weather Forecast
//
//  Created by Nghia on 9/19/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeather  {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    init() {
        _cityName = ""
        _date = ""
        _weatherType = ""
        _currentTemp = 0.0
    }
    
    func downloadCurrentWeather(completed: @escaping DownloadComplete){
        
        Alamofire.request(FORECAST_API_URL).responseJSON { (response) in
            
            let result = response.result
            
            let json = JSON(result.value)
            // Get city name
            self._cityName = json["name"].stringValue
            print(self._cityName)
            
            // Get weather type
            self._weatherType = json["weather"][0]["main"].stringValue
            print(self._weatherType)
            
            //Get temp
            let downloadedTemp = json["main"]["temp"].double
            self._currentTemp = (downloadedTemp! - 273.15).rounded(toPlaces: 0)
            print(self._currentTemp)
            
            // get date
            let tempDate = json["dt"].double
            let convertDate = Date(timeIntervalSince1970: tempDate!)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            self._date = dateFormatter.string(from: convertDate)
            print(self._date)
            
            completed()
        }
    }
}
