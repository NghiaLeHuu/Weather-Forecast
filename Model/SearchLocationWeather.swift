//
//  SearchLocationWeather.swift
//  Weather Forecast
//
//  Created by Tuong on 9/24/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class SearchLocationWeather {
    
    var Location:String!
    var Temp:Double!

    func downloadSearchLocationWeather(LocationString locationstr:String, withLocationCoordinate CLLocation:CLLocationCoordinate2D,completed: @escaping ()->()) {
        
        //Pass the latitude and longtitude to the API URL to get JSON data
        let SEARCH_API_URL = "https://api.darksky.net/forecast/65bf210f4c02766ee3128f1b1728a557/\(CLLocation.latitude),\(CLLocation.longitude)"
        
        //print the location to check
        print(SEARCH_API_URL)
        
        Location = locationstr
        
        Alamofire.request(SEARCH_API_URL).responseJSON { (response) in
            //Using Alamofire to get data from the API
            let result = response.result
            //Using swiftJSON to get data
            let json = JSON(result.value!)
            //Get temp from the API
            let _temp = json["currently"]["temperature"].double
            self.Temp = ((_temp! - 32)*5/9).rounded(toPlaces: 0)
    
            completed()
        }
    }
    
    
    
    
}
