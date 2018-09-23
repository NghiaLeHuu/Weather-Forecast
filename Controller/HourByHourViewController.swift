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
    
    var arrHourly:[HourByHourWeather] = []
    
    @IBOutlet weak var HourByHourTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHourly.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourByHour", for: indexPath) as! HourByHourCell
        cell.time.text = String(arrHourly[indexPath.row].hour)
        cell.summary.text = arrHourly[indexPath.row].summary
        cell.temp.text = String(arrHourly[indexPath.row].temp) + " °C"
        return cell
    }
    
    
    func downloadHourByHourtWeather(completed: @escaping ()->()) {
        //let HOUR_API_URL = "https://api.darksky.net/forecast/65bf210f4c02766ee3128f1b1728a557/10.83,-106.67"
        print(HOUR_API_URL)
        Alamofire.request(HOUR_API_URL).responseJSON { (response) in
            
            let result = response.result
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
