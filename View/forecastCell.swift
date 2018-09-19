//
//  forecastCell.swift
//  Weather Forecast
//
//  Created by Doan The Dang Khoa on 9/19/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import UIKit

class forecastCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    @IBOutlet weak var Temp: UILabel!
    @IBOutlet weak var Day: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(forecastData: ForecastWeather) {
        self.Day.text = "\(String(forecastData.date))"
        self.Temp.text = "\(Int(forecastData.temp))"
        
    }
}
