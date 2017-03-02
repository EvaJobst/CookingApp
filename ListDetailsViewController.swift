//
//  ListDetailsView.swift
//  CookingApp
//
//  Created by Eva Jobst on 25.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit

class ListDetailsViewController: UITableViewController {
    var selectedListID : Int16 = 0
    var data : [Recipe] = []
    let entities = EntityManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = getRecipes()
        self.tableView.register(UINib (nibName: "CustomRecipeCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        tableView.rowHeight = 100
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image : UIImage = UIImage(named: data[indexPath.row].image!)!
        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")! as! CustomRecipeCell
        //cell.recipeTitle.text = data[indexPath.row].label
        //cell.recipeDetails.text = data[indexPath.row].summary
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
        
        for i in 0..<entities.tables.count {
            if(entities.tables[i].listID == selectedListID) {
                retRecipes.append(entities.recipes[Int(entities.tables[i].recipeID)])
            }
        }
        
        return retRecipes
    }
    
}
