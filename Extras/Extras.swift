/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Le Huu Nghia, Doan The Dang Khoa, Chau Phuoc Tuong
 ID: s3654028, s3517738, s3634247
 Created date: 7/9/2019
 Acknowledgment:
 https://stackoverflow.com/questions/26849237/swift-convert-unix-time-to-date-and-time
 https://stackoverflow.com/questions/38213885/convert-kelvin-into-celsius-in-swift
 https://developer.apple.com/documentation/foundation/unittemperature
 https://github.com/Alamofire/Alamofire
 https://github.com/SwiftyJSON/SwiftyJSON
 https://www.hackingwithswift.com/example-code/libraries/how-to-parse-json-using-swiftyjson
 https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/
 https://www.raywenderlich.com/443-auto-layout-tutorial-in-ios-11-getting-started
 https://hackernoon.com/understanding-auto-layout-in-xcode-9-2719710f0706
 https://github.com/loopwxservices/WXKDarkSky
 https://darksky.net/dev/docs#time-machine-request
 https://iosdevcenters.blogspot.com/2016/09/infoplist-privacy-settings-in-ios-10.html
 https://www.hackingwithswift.com/example-code/location/how-to-read-the-users-location-while-your-app-is-in-the-background
 https://developer.apple.com/documentation/corelocation/choosing_the_authorization_level_for_location_services/requesting_always_authorization
 https://stackoverflow.com/questions/45033600/not-able-to-add-privacy-location-always-and-when-in-use-usage-description-in?rq=1
 https://stackoverflow.com/questions/26741591/how-to-get-current-longitude-and-latitude-using-cllocationmanager-swift
 http://swiftdeveloperblog.com/code-examples/determine-users-current-location-example-in-swift/
 http://www.seemuapps.com/swift-get-users-location-gps-coordinates
 https://teamtreehouse.com/community/how-can-i-pass-the-latitude-and-longitude-data-from-cllocationmanager-delegate-to-forecasturl
 https://stackoverflow.com/questions/40648284/converting-a-unix-timestamp-into-date-as-string-swift
 https://stackoverflow.com/questions/28854066/convert-timestamp-into-nsdate-swift/37416339#37416339
 https://developer.apple.com/documentation/corelocation
 https://www.oodlestechnologies.com/blogs/How-to-Use-Core-Location-in-iOS-Swift
 https://www.raywenderlich.com/5247-core-location-tutorial-for-ios-tracking-visited-locations
 */


import Foundation

let API_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=4a5832132568acc447e672a614d171d6"


let FORECAST_API_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=8&appid=7c609f73c5df2dff2f32e3e3cc33cd23"

let HOUR_API_URL = "https://api.darksky.net/forecast/65bf210f4c02766ee3128f1b1728a557/\(Location.sharedInstance.latitude!),\(Location.sharedInstance.longitude!)"


