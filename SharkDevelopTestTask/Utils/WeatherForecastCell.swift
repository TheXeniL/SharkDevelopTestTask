//
//  WeatherForecastCell.swift
//  SharkDevelopTestTask
//
//  Created by Nikita Elizarov on 06/04/2018.
//  Copyright © 2018 Nikita Elizarov. All rights reserved.
//

import UIKit

class WeatherForecastCell: UITableViewCell {

    @IBOutlet weak var weatherForecastIcon: UIImageView!
    @IBOutlet weak var weatherForecastMaxTemperature: UILabel!
    @IBOutlet weak var weatherForecastDate: UILabel!
    @IBOutlet weak var weatherForecastMinTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
