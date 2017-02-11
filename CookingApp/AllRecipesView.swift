//
//  ViewController.swift
//  CookingApp
//
//  Created by Eva Jobst on 09.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class AllRecipesView: UITableViewController {
    var data : [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image : UIImage = UIImage(named: "cheesecake.jpg")!
        let r1 : Recipe = Recipe(title: "Title 1", details: "Details 1 Lorum Ipsum jfka jfkdajieony keajkl djklaejlk jdklajklejainxyke  ajekljlkje jekljakle  jeke ajek s", image: image)
        let r2 : Recipe = Recipe(title: "Title 2", details: "Details 2", image: image)
        let r3 : Recipe = Recipe(title: "Title 3", details: "Details 3", image: image)
        data.append(r1)
        data.append(r2)
        data.append(r3)
        
        tableView.rowHeight = 100
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "CustomRecipeCell")! as! CustomRecipeCell
        
        
        cell.recipeTitle.text = data[indexPath.row].title
        cell.recipeDetails.text = data[indexPath.row].details
        cell.backgroundView = UIImageView(image: data[indexPath.row].image)
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

