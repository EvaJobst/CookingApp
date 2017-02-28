//
//  IngredientTableViewCell.swift
//  CookingApp
//
//  Created by Hannes on 28.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var ingredient: Ingredient? {
        didSet {
            if let item = ingredient {
                numberLabel.text = item.number
                measurementLabel.text = item.measurement
                nameLabel.text = item.name
            }
            else {
                numberLabel.text = nil
                measurementLabel.text = nil
                nameLabel.text = nil
            }
        }
    }
    

}
