//
//  AddRecipeView.swift
//  CookingApp
//
//  Created by Hannes on 24.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit

class AddRecipeView : UITableViewController {

    
    @IBOutlet weak var measurement: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: (#selector(AddRecipeView.onLabelTap)))
        measurement.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    func onLabelTap() {
        
        
        var picker = ActionSheetStringPicker()
        
        ActionSheetStringPicker.show(withTitle: "Multiple String Picker", rows: [
            ["One", "Two", "A lot"],
            ["Many", "Many more", "Infinite"]
            ], initialSelection: [2, 2], doneBlock: {
                picker, indexes, values in
                
                print("values = \(values)")
                print("indexes = \(indexes)")
                print("picker = \(picker)")
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    

}
