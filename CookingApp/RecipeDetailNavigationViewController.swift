//
//  RecipeDetailNavigationViewController.swift
//  CookingApp
//
//  Created by Hannes on 03.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeDetailNavigationViewController: UINavigationController {

    var selectedListID : Int16 = 0
    var indexOfSelectedElement = 0
    var row = 0
    
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

}
