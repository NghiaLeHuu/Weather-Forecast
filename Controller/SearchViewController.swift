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
     var arrLocation:[String] = []
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Delete") { (rowAction, indexPath) in
            self.arrSearchWeather.remove(at: indexPath.row)
            self.arrLocation.remove(at: indexPath.row)
            UserDefaults.standard.set(self.arrLocation, forKey: "arrLocation")
            self.searchWeatherTableView.reloadData()
        }
        
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //Check if the list is empty
        if UserDefaults.standard.object(forKey: "arrLocation") == nil{
            // do nothing then move to else statement
        }else{
            //Get data from UserDefaults then save to arrLocation
            arrLocation = UserDefaults.standard.object(forKey: "arrLocation") as! [String]
            //Get data from API then pass the data to the arrLocation from UserDefaults
            for item in arrLocation{
                updateWeatherForLocation(location: item)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            updateWeatherForLocation(location: locationString)
            // Saving data
            arrLocation.append(locationString)
            UserDefaults.standard.set(arrLocation, forKey: "arrLocation")
        }
    }
    
    func updateWeatherForLocation(location:String){
        
        let locationString = location
    
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if error == nil{
                if let location = placemarks?.first?.location{
                    //Print the latitude and longtitude of the location is searched
                    print(location.coordinate.latitude)
                    print(location.coordinate.longitude)
                    
                    let searchWeather = SearchLocationWeather()
                    
                    searchWeather.downloadSearchLocationWeather(LocationString: locationString, withLocationCoordinate: location.coordinate, completed: {
                        
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
