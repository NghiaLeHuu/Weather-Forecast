//
//  HourByHourViewController.swift
//  Weather Forecast
//
//  Created by Tuong on 9/23/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

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
