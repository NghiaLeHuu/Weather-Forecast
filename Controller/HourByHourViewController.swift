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

import UIKit
import Alamofire

class HourByHourViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    //Variables
    var arrHourly:[HourByHourWeather] = []
    
    //Outlets
    @IBOutlet weak var HourByHourTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHourly.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourByHour", for: indexPath) as! HourByHourCell
        cell.time.text = String(arrHourly[indexPath.row].hour)
        cell.summary.text = arrHourly[indexPath.row].summary
        cell.temp.text = String(arrHourly[indexPath.row].temp) + "°C"
        return cell
    }
    //Download forecast weather hour by hour
    func downloadHourByHourtWeather(completed: @escaping ()->()) {
        Alamofire.request(HOUR_API_URL).responseJSON { (response) in
            //Taking data from the API
            let result = response.result
            //Taking hourly weather data from the API
            if let dic = result.value as? [String:Any]{
                if let hourly = dic["hourly"] as? [String:Any]{
                    if let hourlyData = hourly["data"] as? [[String:Any]]{
                        for item in hourlyData {
                            let hourByhour = HourByHourWeather(hourlyDict: item)
                            self.arrHourly.append(hourByhour)
                        }
                    }
                }
            }
            completed()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.downloadHourByHourtWeather{
            print("Download DATA")
            self.HourByHourTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
