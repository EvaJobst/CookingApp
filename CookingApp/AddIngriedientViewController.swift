//
//  AddIngriedientViewController.swift
//  CookingApp
//
//  Created by Hannes on 27.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit


class AddIngriedientViewController: UITableViewController {
    
    
    //@IBOutlet weak var measureButton: UIButton!
    
    
    var items = [Ingredient(number: "2", measurement: "kg", name: "Zucker"), Ingredient(number: "1", measurement: "g", name: "Zucker"), Ingredient(number: "2", measurement: "dag", name: "Zucker")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddIngriedientViewController.addNewItem(notif:)), name: NSNotification.Name(rawValue: "AddNewItem"), object: nil)
    }
    
    
    //Handler
    func addNewItem(notif: NSNotification) {
        
        print("MyNotification was handled");
        let measure = notif.userInfo!["measurement"] as! String
        let number = notif.userInfo!["number"] as! String
        let name = notif.userInfo!["name"] as! String
        
        items.append(Ingredient(number: number, measurement: measure, name: name))
        
    }
    
    
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }  
    
    override func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
        cell.ingredient = item
        
        return cell
        
    }
 
}
