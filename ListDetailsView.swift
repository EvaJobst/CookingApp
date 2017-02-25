//
//  ListDetailsView.swift
//  CookingApp
//
//  Created by Eva Jobst on 25.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit

class ListDetailsView: UITableViewController {
    var selectedListID : Int16 = 0
    var data : [Recipe] = []
    var recipes : [Recipe] = []
    var lists : [List] = []
    var tables : [RecipeListTable] = []
    let recipeManager = CoreDataManager(entityName: "Recipe")
    let listManager = CoreDataManager(entityName: "List")
    let tableManager = CoreDataManager(entityName: "RecipeListTable")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Starting here: Code feeding DummyData
        recipes = recipeManager.fetchedEntity! as! [Recipe]
        lists = listManager.fetchedEntity! as! [List]
        tables = tableManager.fetchedEntity! as! [RecipeListTable]
        
        for i in 0..<tables.count {
            tableManager.delete(entity: tables[i])
        }
        
        tableManager.save()
        tableManager.update()
        
        tableManager.setTable(listID: 0, recipeID: 0)
        tableManager.setTable(listID: 0, recipeID: 1)
        tableManager.setTable(listID: 0, recipeID: 2)
        tableManager.setTable(listID: 1, recipeID: 0)
        tableManager.setTable(listID: 3, recipeID: 0)
        tableManager.setTable(listID: 3, recipeID: 2)
        
        tables = tableManager.fetchedEntity! as! [RecipeListTable]
        
        data = getRecipes()
        tableView.rowHeight = 100
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image : UIImage = UIImage(named: data[indexPath.row].image!)!
        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "listDetailsCell")! as! CustomRecipeCell
        
        cell.recipeTitle.text = data[indexPath.row].name
        cell.recipeDetails.text = data[indexPath.row].details
        cell.backgroundView = UIImageView(image: image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRecipes () -> [Recipe] {
        var retRecipes : [Recipe] = []
        
        for i in 0..<tables.count {
            if(tables[i].listID == selectedListID) {
                retRecipes.append(recipes[Int(tables[i].recipeID)])
            }
        }
        
        return retRecipes
    }

}
