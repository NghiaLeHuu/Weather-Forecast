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

class ViewController: UIViewController {
    
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
    var forecastArray = [ForecastWeather]()
    
    
    @IBOutlet weak var ForeCastTableView: UITableView!
    
    // run it first
    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeather = CurrentWeather()
//        currentWeather.downloadCurrentWeather {
//            self.cityName.text = self.currentWeather._cityName
//            self.weatherType.text = self.currentWeather._weatherType
//            self.currentCityTemp.text = "\(Int(self.currentWeather._currentTemp))"
//            self.currentDate.text = self.currentWeather._date
//        }
//        print("Data Downloaded")
        ForeCastTableView.delegate = self
        ForeCastTableView.dataSource = self
        downloadForecastWeather {
            print("DATA DOWNLOADED")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    
    
    func downloadForecastWeather(completed: @escaping ()->()) {
        Alamofire.request(FORECAST_API_URL).responseJSON { (response) in
            let result = response.result
            //print(result.value)
            if let dic = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dic["list"] as? [Dictionary<String, AnyObject>] {
                    for item in list {
                        let forecast = ForecastWeather(weatherDict: item)
                        //print(forecast.date)
                        //print(forecast.temp)
                        self.forecastArray.append(forecast)
                    }
                    self.forecastArray.remove(at: 0)
                    self.ForeCastTableView.reloadData()
                }
            }
            completed()
        }
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! forecastCell
        //cell.configureCell(temp:10,day:"mn")
        cell.configureCell(forecastData: forecastArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
}





