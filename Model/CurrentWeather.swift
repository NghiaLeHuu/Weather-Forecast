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
        
        // Using Alamofire to access the API
        Alamofire.request(API_URL).responseJSON { (response) in
            let result = response.result
            
            //Download data from API
            let json = JSON(result.value!)
            print(result.value!)
            
            // get CityName
            self.cityName = json["name"].stringValue
            
            // get weatherType
            self.weatherType = json["weather"][0]["main"].stringValue
            
            // get currentTemp
            let downloadedTemp = json["main"]["temp"].double
            self.currentTemp = (downloadedTemp! - 273.15).rounded(toPlaces: 0)
            
            // get date
            let tempDate = json["dt"].double
            //Convert date to timestamp
            let convertDate = Date(timeIntervalSince1970: tempDate!)
            //Adjust format of date when it displays in the UI
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            self.date = dateFormatter.string(from: convertDate)
            
            completed()
        }
    }
    
}
