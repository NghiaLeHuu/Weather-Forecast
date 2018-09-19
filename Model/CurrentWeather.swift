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

class CurrentWeather {
    
    var cityName:String!
    var weatherType:String!
    var currentTemp:Double!
    var date:String!
    
    init(){
        cityName = ""
        weatherType = ""
        currentTemp = 0.0
        date = ""
    }
    
    
    func downloadCurrentWeathers(completed:@escaping ()->()){
        // Using Alamofire
        Alamofire.request(API_URL).responseJSON { (response) in
            let result = response.result
            
            let json = JSON(result.value!)
            print(result.value!)
            // get CityName
            self.cityName = json["name"].stringValue
            //print(self.cityName)
            
            // get weatherType
            self.weatherType = json["weather"][0]["main"].stringValue
            //print(self.weatherType)
            
            // get currentTemp
            let downloadedTemp = json["main"]["temp"].double
            self.currentTemp = (downloadedTemp! - 273.15).rounded(toPlaces: 0)
            //print(self.currentTemp)
            
            // get date
            let tempDate = json["dt"].double
            //print(tempDate)
            let convertDate = Date(timeIntervalSince1970: tempDate!)
            //print(convertDate)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            self.date = dateFormatter.string(from: convertDate)
            //print(self.date)
            
            completed()
        }
    }
    
}
