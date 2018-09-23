//
//  Extras.swift
//  Weather Forecast
//
//  Created by Nghia on 9/17/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import Foundation

let API_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=4a5832132568acc447e672a614d171d6"

let FORECAST_API_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=10.83&lon=106.67&cnt=8&appid=7c609f73c5df2dff2f32e3e3cc33cd23"

let HOUR_API_URL = "https://api.darksky.net/forecast/65bf210f4c02766ee3128f1b1728a557/\(Location.sharedInstance.latitude!),\(Location.sharedInstance.longitude!)"

//let API_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=4a5832132568acc447e672a614d171d6"
