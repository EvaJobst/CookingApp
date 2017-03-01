//
//  InstructionViewController.swift
//  CookingApp
//
//  Created by Hannes on 01.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {

    @IBOutlet weak var instructionText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        print("Send Notification!!!!")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddNewInstruction"), object: nil, userInfo: ["instruction" : instructionText.text]); // send
        
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
