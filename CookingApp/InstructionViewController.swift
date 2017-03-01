//
//  InstructionViewController.swift
//  CookingApp
//
//  Created by Hannes on 01.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit
import Toast_Swift

class InstructionViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var instructionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        instructionText.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    @IBAction func addAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        print("Send Notification!!!!")
        if (instructionText.text != ""){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddNewInstruction"), object: nil, userInfo: ["instruction" : instructionText.text]); // send
            
            instructionText.text = ""
            
        }
        else {
            self.view.makeToast("Please enter an instruction")
        }
        
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

}
