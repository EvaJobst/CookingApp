//
//  RecipeListsView.swift
//  CookingApp
//
//  Created by Eva Jobst on 25.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeListsView: UITableViewController {
    var data : [List] = []
    let manager = CoreDataManager(entityName: "List")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Starting here: Code feeding DummyData
        data = manager.fetchedEntity! as! [List]
        for i in 0..<data.count {
            manager.delete(entity: data[i])
        }
        
        manager.save()
        manager.update()
        
        manager.setList(listID: 0, numOfRecipes: 3, name: "Favorite desserts")
        manager.setList(listID: 1, numOfRecipes: 23, name: "Inspiration")
        manager.setList(listID: 2, numOfRecipes: 1, name: "For the next dinner party")
        manager.setList(listID: 3, numOfRecipes: 4, name: "Best cakes")
        
        data = manager.fetchedEntity! as! [List]
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        cell.textLabel?.text = data[indexPath.row].name
        cell.detailTextLabel?.text = data[indexPath.row].numOfRecipes.description + " recipes"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

