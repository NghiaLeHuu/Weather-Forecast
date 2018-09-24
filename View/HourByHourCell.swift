//
//  HourByHourCell.swift
//  Weather Forecast
//
//  Created by Tuong on 9/23/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import UIKit

class HourByHourCell: UITableViewCell {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
