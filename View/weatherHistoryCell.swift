//
//  weatherHistoryCell.swift
//  Weather Forecast
//
//  Created by Doan The Dang Khoa on 9/27/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import UIKit

class weatherHistoryCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
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
