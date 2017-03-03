//
//  RecipeListsTableViewCell.swift
//  CookingApp
//
//  Created by Hannes on 03.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeListsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    var menuItem : String? {
        didSet {
            if let item = menuItem {
                titleLabel.text = item
            }
            else {
                titleLabel.text = nil
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
