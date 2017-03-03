//
//  MainMenuTableViewController.swift
//  CookingApp
//
//  Created by Hannes on 03.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {

    var nameOfCurrenteList : String = ""
    var menuItems : [String] = []
    var currentItem = "Your Lists"
    var action : String = ""
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        let r = 51.0 / 255.0
        let g = 64.0 / 255.0
        let b = 80.0 / 255.0
        
        self.view.backgroundColor = UIColor(red:CGFloat(r), green:CGFloat(g), blue:CGFloat(b), alpha:1)
        
        menuItems = ["", "", action, "", "Cookbook", "Your Lists", "Settings"]
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
        
        
        let r = 96.0 / 255.0
        let g = 121.0 / 255.0
        let b = 151.0 / 255.0
        
        let color = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
        
        cell.titleLabel.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : color
        cell.backgroundColor = UIColor.clear
        
        if (cell.titleLabel.text == ""){
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.isUserInteractionEnabled = false
        }
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let menuTableViewController = segue.source as! MainMenuTableViewController
        
        if let selectedRow = menuTableViewController.tableView.indexPathForSelectedRow?.row {
            currentItem = menuItems[selectedRow]
        }
        
    }

}