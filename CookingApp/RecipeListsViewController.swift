//
//  RecipeListsView.swift
//  CookingApp
//
//  Created by Eva Jobst on 25.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeListsViewController: UITableViewController {
    var entities : EntityManager? = nil
    var selectedListID : Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entities = EntityManager()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities!.lists.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        cell.textLabel?.text = entities?.lists[indexPath.row].name
        cell.detailTextLabel?.text = (entities?.lists[indexPath.row].numOfRecipes.description)! + " recipes"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedListID = Int16(indexPath.row)
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            if let viewInstance = segue.destination as? ListDetailsViewController {
                viewInstance.selectedListID = selectedListID
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

