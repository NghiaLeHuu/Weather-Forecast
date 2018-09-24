//
//  SearchViewController.swift
//  Weather Forecast
//
//  Created by Tuong on 9/24/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var arrSearchWeather:[SearchLocationWeather] = []
    
    @IBOutlet weak var searchWeatherTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSearchWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchLocation", for: indexPath) as! SearchLocationCell
        cell.Location.text = arrSearchWeather[indexPath.row].Location
        cell.Temp.text = String(arrSearchWeather[indexPath.row].Temp) + " °C"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWeatherForLocation(location: "New York")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            updateWeatherForLocation(location: locationString)
        }
    }
    
    func updateWeatherForLocation(location:String){
        
        let locationString = location
    
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if error == nil{
                if let location = placemarks?.first?.location{
                    
                    print(location.coordinate.latitude)
                    print(location.coordinate.longitude)
                    
                    let searchWeather = SearchLocationWeather()
                    
                    searchWeather.downloadSearchLocationWeather(LocationString: locationString, withLocationCoordinate: location.coordinate, completed: {
                        
                        print(searchWeather.Location)
                        print(searchWeather.Temp)
                        
                        self.arrSearchWeather.append(searchWeather)
                        self.searchWeatherTableView.reloadData()
                        
                    })
                    
                }
            
            }
        }
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
