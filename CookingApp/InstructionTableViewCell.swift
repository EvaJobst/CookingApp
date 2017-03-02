//
//  InstructionTableViewCell.swift
//  CookingApp
//
//  Created by Hannes on 01.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var InstructionLabel: UILabel!
    
    
    var instruction : Instruction? {
        didSet {
            if let item = instruction {
                numberLabel.text = String(item.number)
                InstructionLabel.text = item.instruction
                //InstructionLabel.layer.borderWidth = 1
            }
            else {
                numberLabel.text = nil
                InstructionLabel.text = nil
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
