//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Nghia on 9/17/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

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





