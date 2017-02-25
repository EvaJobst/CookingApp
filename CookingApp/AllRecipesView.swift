//
//  AllRecipesView.swift
//  CookingApp
//
//  Created by Eva Jobst on 09.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class AllRecipesView: UITableViewController {
    var data : [Recipe] = []
    let manager = CoreDataManager(entityName: "Recipe")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Starting here: Code feeding DummyData
        data = manager.fetchedEntity! as! [Recipe]
        for i in 0..<data.count {
            manager.delete(entity: data[i])
        }
        
        manager.save()
        manager.update()
        
        manager.setRecipe(recipeID: 0, fetchID: "0", name: "Recipe 1", details: "A very tasty cookie!", image: "cheesecake.jpg")
        
        manager.setRecipe(recipeID: 1, fetchID: "1", name: "Recipe 2", details: "This might probably be the most beautiful cheesecake I have ever had the chance to encounter. Magnificent! Brilliant! Astonishing!", image: "cheesecake.jpg")
        
        manager.setRecipe(recipeID: 2, fetchID: "2", name: "Recipe 3", details: "This spaghetti with seafood makes you think of a venetian summer night like you have never before.", image: "cheesecake.jpg")
    
        data = manager.fetchedEntity! as! [Recipe]
        tableView.rowHeight = 100
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image : UIImage = UIImage(named: data[indexPath.row].image!)!
        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "CustomRecipeCell")! as! CustomRecipeCell

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


}

