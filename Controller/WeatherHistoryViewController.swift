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
import SwiftyJSON

class WeatherHistoryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var weatherHistoryTableView: UITableView!
    
    //Variables
    var arrHistoryDay:[Int] = []
    var currentTime:Int!
    var arrHistoryAPIURL:[String] = []
    var arrWeatherHistory:[WeatherHistory] = []
    var date:Date = Date()
    var arrDate:[Date]!
    var sortedDate:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWeatherHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherHistory", for: indexPath) as! weatherHistoryCell
        cell.time.text = sortedDate[indexPath.row]
        cell.temp.text = String(arrWeatherHistory[indexPath.row].temp)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherHistoryTableView.delegate = self
        currentTimeWeather()
    }
    
    @IBAction func reloadTableView(_ sender: Any) {
        self.SortArray(_arrWeatherHistoy: self.arrWeatherHistory)
        weatherHistoryTableView.reloadData()
        print("reload data")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func currentTimeWeather(){
        let _currentTime = CurrentTime()
        _currentTime.getCurrentTime(completed: {
            //Get historical timestamp of 7 days
            for index in 1...7{
                let thePastDate = _currentTime.currentTime - (index) *  86400
                self.arrHistoryDay.append(thePastDate)
            }
            //Pass historical timestamp of 7 days to the API
            for item in self.arrHistoryDay{
                let HISTORY_API_URL = "https://api.darksky.net/forecast/65bf210f4c02766ee3128f1b1728a557/\(Location.sharedInstance.latitude!),\(Location.sharedInstance.longitude!),\(item)"
                
                self.arrHistoryAPIURL.append(HISTORY_API_URL)
               // print(HISTORY_API_URL)
            }
            //Reload the data after passing historical timestamp
            self.RunFinished(arr: self.arrHistoryAPIURL, co: {
                self.weatherHistoryTableView.reloadData()
            })
        })
    }
    
    //Run this after calculating the historical time
    func RunFinished(arr:[Any], co: @escaping ()->()) {
        for item in self.arrHistoryAPIURL{
            let weatherHistory = WeatherHistory()
            weatherHistory.downloadWeatherHistory(HISTORY_API_URL: item, completed: {
                self.arrWeatherHistory.append(weatherHistory)
                print(self.arrWeatherHistory)
            })
        }
        co()
    }
    
    //Sort the date in the display tableview
    func SortArray(_arrWeatherHistoy:[WeatherHistory]){
        var convertedArray: [Date] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        for dat in _arrWeatherHistoy {
            let date = dateFormatter.date(from: dat.time)
            if let date = date {
                convertedArray.append(date)
            }
        }
        //Compare the first date and the second date in the list and sort the date
        arrDate = convertedArray.sorted(by: { $0.compare($1) == .orderedDescending })
        print(arrDate)
        
        for item in arrDate{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let time = dateFormatter.string(from: item)
            sortedDate.append(time)
        }
    }
}
