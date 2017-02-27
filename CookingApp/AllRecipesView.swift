//
//  AllRecipesView.swift
//  CookingApp
//
//  Created by Eva Jobst on 09.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class AllRecipesView: UITableViewController {
    let entities = EntityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entities.deletingDummyData()
        entities.feedingDummyData()
        
        tableView.rowHeight = 100
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.recipes.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image : UIImage = UIImage(named: entities.recipes[indexPath.row].image!)!
        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "allRecipesCell")! as! CustomRecipeCell

        cell.recipeTitle.text = entities.recipes[indexPath.row].name
        cell.recipeDetails.text = entities.recipes[indexPath.row].details
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


}

