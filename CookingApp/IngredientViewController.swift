//
//  IngredientViewController.swift
//  CookingApp
//
//  Created by Hannes on 28.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class IngredientViewController: UIViewController {

    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var numberLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addAction(_ sender: Any) {

        print("Send Notification!!!!")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddNewItem"), object: nil, userInfo: ["measurement" : measureButton.title(for: .normal) ?? "Measure", "number": numberLabel.text ?? "Number", "name": nameLabel.text ?? "Name"]); // send
        
    }
    
    @IBAction func TouchButtonAction(_ sender: Any) {
        
        ActionSheetStringPicker.show(withTitle: "Pick measurement", rows: ["kg", "g", "dag", "prise", "pounds", "knife tip", "teaspoon", "tablespoon"], initialSelection: 0, doneBlock: {
            picker, value, index in
            
            print("value = \(value)")
            print("index = \(index)")
            print("picker = \(picker)")
            
            switch value {
                
            case 0:
                self.measureButton.setTitle("kg", for: .normal)
            case 1:
                self.measureButton.setTitle("g", for: .normal)
            case 2:
                self.measureButton.setTitle("dag", for: .normal)
            case 3:
                self.measureButton.setTitle("prise", for: .normal)
            case 4:
                self.measureButton.setTitle("pounds", for: .normal)
            case 5:
                self.measureButton.setTitle("knife tip", for: .normal)
            case 6:
                self.measureButton.setTitle("teaspoon", for: .normal)
            case 7:
                self.measureButton.setTitle("tablespoon", for: .normal)
            default:
                self.measureButton.setTitle("Please pick measurement", for: .normal)
            }
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
        
        
        
    }
    
    
}
