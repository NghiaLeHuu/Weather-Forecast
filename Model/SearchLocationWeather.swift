//
//  SearchLocationWeather.swift
//  Weather Forecast
//
//  Created by My Vo on 9/24/18.
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
        
        let SEARCH_API_URL = "https://api.darksky.net/forecast/65bf210f4c02766ee3128f1b1728a557/\(CLLocation.latitude),\(CLLocation.longitude)"
        
        print(SEARCH_API_URL)
        
        Location = locationstr
        
        Alamofire.request(SEARCH_API_URL).responseJSON { (response) in
            
            let result = response.result
            
            let json = JSON(result.value!)
            
            // get temp (searchLocation)
            let _temp = json["currently"]["temperature"].double
            self.Temp = ((_temp! - 32)*5/9).rounded(toPlaces: 0)
    
            completed()
        }
    }
    
    
    
    
}