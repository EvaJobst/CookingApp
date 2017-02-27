//
//  AddRecipeView.swift
//  CookingApp
//
//  Created by Hannes on 24.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0

class AddRecipeView : UITableViewController {

    
    @IBOutlet weak var measurement: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: (#selector(AddRecipeView.onLabelTap)))
        measurement.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    func onLabelTap() {
        
        ActionSheetStringPicker.show(withTitle: "Pick measurement", rows: ["kg", "g", "dag", "pounds"], initialSelection: 0, doneBlock: {
                picker, indexes, values in
                
                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
        }, cancel: { ActionSheetStringCancelBlock in return }, origin: measurement)
       
    }
    
    

}
