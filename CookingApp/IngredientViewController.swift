//
//  IngredientViewController.swift
//  CookingApp
//
//  Created by Hannes on 28.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import Toast_Swift

class IngredientViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    var onlyNumber : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        numberText.delegate = self
        nameText.delegate = self
        
        hideKeyboard()
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        //let text = (numberText.text! as NSString).replacingCharacters(in: range, with: string)
        let text = numberText.text!
        
        if Int(text) != nil {
           onlyNumber = true
        } else {
            onlyNumber = false
        }
        
        // Return true so the text field will be changed
        return true
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

        self.view.endEditing(true)
        
        if onlyNumber {
            print("Send Notification!!!!")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddNewIngredient"), object: nil, userInfo: ["measurement" : measureButton.title(for: .normal) ?? "Measure", "number": numberText.text ?? "Number", "name": nameText.text ?? "Name"]); // send
            
            numberText.text = ""
            nameText.text = ""
            
        }
        else {
            self.view.makeToast("Please check your entered data")
        }
        
        
    }
    
    @IBAction func TouchButtonAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        ActionSheetStringPicker.show(withTitle: "Pick measurement", rows: ["kg", "g", "dag", "prise", "pounds"], initialSelection: 0, doneBlock: {
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
            default:
                self.measureButton.setTitle("Please pick measurement", for: .normal)
            }
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
        
        
        
    }
    
    
}
