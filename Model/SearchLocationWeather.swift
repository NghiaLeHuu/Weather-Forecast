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
