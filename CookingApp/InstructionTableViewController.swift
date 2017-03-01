//
//  InstructionTableViewController.swift
//  CookingApp
//
//  Created by Hannes on 01.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class InstructionTableViewController: UITableViewController {

    
    var items = [Instruction]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.rowHeight = UITableViewAutomaticDimension
    
        NotificationCenter.default.addObserver(self, selector: #selector(AddIngriedientViewController.addNewItem(notif:)), name: NSNotification.Name(rawValue: "AddNewInstruction"), object: nil)
        
    }
    
    
    //Handler
    func addNewItem(notif: NSNotification) {
        
        print("MyNotification was handled");
        let instruction = notif.userInfo!["instruction"] as! String
        
        if instruction != "" {
            items.append(Instruction(number: items.count+1, instruction: instruction))
            self.tableView.reloadData()
        }
        else {
            //self.view.makeToast("Please check your input")
            
        }
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            items.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    

    
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as! InstructionTableViewCell
        
        cell.instruction = item
        
        return cell
    }
    
    
    // TO DO - CHANGEABLE HEIGHT
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
