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
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate{
    
    //Outlets
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var currentCityTemp: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var specialBG: UIImageView!
    
    //Variables
    let locationManager = CLLocationManager()
    
    //Constants
    var currentWeather: CurrentWeather!
    var forecastArray = [ForecastWeather]()
    var currentLocation:CLLocation!
    
    @IBOutlet weak var ForeCastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeather = CurrentWeather()
        ForeCastTableView.delegate = self
        ForeCastTableView.dataSource = self
       
        setupLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Download forecast weather
    func downloadForecastWeather(completed: @escaping ()->()) {
        Alamofire.request(FORECAST_API_URL).responseJSON { (response) in
            //Taking the data from the API
            let result = response.result
            //Taking forecast weather data for 7 days
            if let dic = result.value as? Dictionary<String, AnyObject> {
                if let list = dic["list"] as? [Dictionary<String, AnyObject>] {
                    for item in list {
                        let forecast = ForecastWeather(weatherDict: item)
                        self.forecastArray.append(forecast)
                    }
                    //Remove the first day, it is today
                    self.forecastArray.remove(at: 0)
                    self.ForeCastTableView.reloadData()
                }
            }
            completed()
        }
    }

   
    func setupLocation(){
        // Take permission from the user
        locationManager.requestWhenInUseAuthorization()
        //Moving to this step after having permission from the user
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    //Check the location again
    var i:Int = 0
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //Get location (run one time)
        if(i == 0 ){
            locationAuthCheck()
            i = i + 1
        }
    }
    
    func locationAuthCheck() {
        //When the users give the privacy for using location
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //Get the location from the device
            currentLocation = locationManager.location!
            //Pass the location coord to our API
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //Download the API Data
            currentWeather.downloadCurrentWeathers {
                self.cityName.text = self.currentWeather.cityName
                self.weatherType.text = self.currentWeather.weatherType
                self.currentCityTemp.text = "\(Int(self.currentWeather.currentTemp))" + "°C"
                self.currentDate.text = self.currentWeather.date
            }
            //Download the Forecast Weather
            downloadForecastWeather {
                print("DATA DOWNLOADED")
            }
            //The user doesn't allow to take the permission
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthCheck()
        }
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! forecastCell
        cell.configureCell(forecastData: forecastArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
}





