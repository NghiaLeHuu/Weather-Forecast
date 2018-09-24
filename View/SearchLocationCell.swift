//
//  SearchLocationCell.swift
//  Weather Forecast
//
//  Created by Tuong on 9/24/18.
//  Copyright © 2018 Nghia. All rights reserved.
//

import UIKit

class SearchLocationCell: UITableViewCell {
    
    
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
