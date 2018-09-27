//
//  WeatherHistory.swift
//  Weather Forecast
//
//  Created by Doan The Dang Khoa on 9/27/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherHistory {
    
    var time:String!
    var temp:Double!
    
    func downloadWeatherHistory(HISTORY_API_ULR H_API_URL:String,completed: @escaping ()->()) {
        
        Alamofire.request(H_API_URL).responseJSON { (response) in
            let result = response.result
            let json = JSON(result.value!)
            
            let _temp = json["currently"]["temperature"].double
            self.temp = ((_temp! - 32)*5/9).rounded(toPlaces: 0)
            print(self.temp)
            
            // get time
            let _time = json["currently"]["time"].double
            
            let convertDate = Date(timeIntervalSince1970: _time!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            self.time = dateFormatter.string(from: convertDate)
            print(self.time)
            
            
            completed()
        }
    }
}
