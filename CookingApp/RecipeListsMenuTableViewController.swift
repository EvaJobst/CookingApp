//
//  RecipeListsMenuTableViewController.swift
//  CookingApp
//
//  Created by Hannes on 03.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeListsMenuTableViewController: UITableViewController {

    
    
    
    var menuItems = ["", "", "Your Lists", "Add Recipe", "Share", "", "Cookbook", "Settings"]
    var currentItem = "Your Lists"
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        let r = 79.0 / 255.0
        let g = 99.0 / 255.0
        let b = 124.0 / 255.0
        
        self.view.backgroundColor = UIColor(red:CGFloat(r), green:CGFloat(g), blue:CGFloat(b), alpha:1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeListsMenuCell", for: indexPath) as! RecipeListsTableViewCell
        
        cell.titleLabel.text = menuItems[indexPath.row]
        cell.titleLabel.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : UIColor.gray
        cell.backgroundColor = UIColor.clear
        
        if (cell.titleLabel.text == ""){
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
        }
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let menuTableViewController = segue.source as! RecipeListsMenuTableViewController
        
        if let selectedRow = menuTableViewController.tableView.indexPathForSelectedRow?.row {
            currentItem = menuItems[selectedRow]
        }
        
    }
}
