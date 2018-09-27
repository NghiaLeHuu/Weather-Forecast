//
//  CurrentTime.swift
//  Weather Forecast
//
//  Created by Doan The Dang Khoa on 9/27/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class CurrentTime {
    
    var currentTime:Int!
    
    func getCurrentTime(completed: @escaping ()->()) {
        print(HOUR_API_URL)
        Alamofire.request(HOUR_API_URL).responseJSON { (response) in
            let result = response.result
            let json = JSON(result.value!)
            let _currentTime = json["currently"]["time"].int
            self.currentTime = _currentTime
            //self.currentTime = json["currently"]["time"].double
            //print(self.currentTime)
            
            completed()
        }
        
    }
    
}
