//
//  WeatherHistoryViewController.swift
//  Weather Forecast
//
//  Created by Doan The Dang Khoa on 9/27/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

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
      //  cell.time.text = arrWeatherHistory[indexPath.row].time
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
    
    func RunFinished(arr:[Any], co: @escaping ()->()) {
        for item in self.arrHistoryAPIURL{
            let weatherHistory = WeatherHistory()
            weatherHistory.downloadWeatherHistory(HISTORY_API_URL: item, completed: {
                self.arrWeatherHistory.append(weatherHistory)
                // sort

                print(self.arrWeatherHistory)
            })
        }
        co()
    }
    

    
    func currentTimeWeather(){
        let _currentTime = CurrentTime()
        _currentTime.getCurrentTime(completed: {
            // get 7 days past time
            for index in 1...7{
                let thePastDate = _currentTime.currentTime - (index) *  86400
                self.arrHistoryDay.append(thePastDate)
               
                
            }
            
            // pass 7 days past time to the API
            for item in self.arrHistoryDay{
                let HISTORY_API_URL = "https://api.darksky.net/forecast/65bf210f4c02766ee3128f1b1728a557/\(Location.sharedInstance.latitude!),\(Location.sharedInstance.longitude!),\(item)"
                
                self.arrHistoryAPIURL.append(HISTORY_API_URL)
               // print(HISTORY_API_URL)
            }
            //reload the data
            self.RunFinished(arr: self.arrHistoryAPIURL, co: {
                self.weatherHistoryTableView.reloadData()
            })
        })
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
