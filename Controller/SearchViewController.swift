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
        cell.Temp.text = String(arrSearchWeather[indexPath.row].Temp) + "°C"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Create delete button to delete the locations are searched
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Delete") { (rowAction, indexPath) in
            self.arrSearchWeather.remove(at: indexPath.row)
            self.arrLocation.remove(at: indexPath.row)
            UserDefaults.standard.set(self.arrLocation, forKey: "arrLocation")
            self.searchWeatherTableView.reloadData()
        }
        //set the background color for the delete button
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //Check if the location list is empty
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
    
    //Create a function for search button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            updateWeatherForLocation(location: locationString)
            // Saving data
            arrLocation.append(locationString)
            UserDefaults.standard.set(arrLocation, forKey: "arrLocation")
        }
    }
    
    //Find the latitude and longitude of the locations are searched
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
}
