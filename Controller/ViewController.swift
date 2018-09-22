//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Nghia on 9/17/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Outlets
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var currentCityTemp: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var specialBG: UIImageView!
    
    //Variables
    let locationManager = CLLocationManager()
    
    
    //Constants
    var currentWeather: CurrentWeather!
    var currentLocation: CLLocation!
    
    // run it first
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeather = CurrentWeather()
        setupLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Request privacy location
    func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startMonitoringSignificantLocationChanges()
            //locationManager.startUpdatingLocation()
        }
    }
    
    // Get a x, y
    var i: Int = 0
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        currentLocation = locationManager.location!
        
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        locationAuthCheck()
    
//        if i == 0 {
//            locationAuthCheck()
//            i = i + 1
//        }
    }
    
    func locationAuthCheck() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //Get the location from the device
            print(currentLocation.coordinate.longitude)
            print(currentLocation.coordinate.latitude)
            
            currentLocation = locationManager.location!
            
            //Pass the location to the lat & long of API_URL
            
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            //Download the data from the API
            currentWeather.downloadCurrentWeather {
                self.cityName.text = self.currentWeather._cityName
                self.weatherType.text = self.currentWeather._weatherType
                self.currentCityTemp.text = "\(Int(self.currentWeather._currentTemp))"
                self.currentDate.text = self.currentWeather._date
            }
        } else {
            do {
                try locationManager.requestWhenInUseAuthorization() // Ask for permission again
            } catch {
                locationAuthCheck() // Make a check
            }
        }
    }

    

}

