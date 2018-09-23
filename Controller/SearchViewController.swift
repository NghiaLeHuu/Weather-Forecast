//
//  SearchViewController.swift
//  Weather Forecast
//
//  Created by My Vo on 9/24/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Button Click")
    }
    
    func updateWeatherForLocation(location:String){
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if error == nil{
                if let location = placemarks?.first?.location{
                    
                    print(location.coordinate.latitude)
                    print(location.coordinate.longitude)
                    
                    //download hour by hour weather
//                    self.downloadForecastWeather {
//                        print("Download DATA")
//                        self.hourTableView.reloadData()
//                    }
                    
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
