//
//  AllRecipesView.swift
//  CookingApp
//
//  Created by Eva Jobst on 09.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit
import Alamofire

class AllRecipesViewController: UITableViewController {
    let fetchKey = "FinishedFetchingRecipes"
    let fetches = FetchManager()
    var data : [RecipeObject] = []
    let entities = EntityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib (nibName: "CustomRecipeCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reload),
            name: Notification.Name(rawValue: fetchKey),
            object: nil)
        
        entities.deletingDummyData()
        entities.feedingDummyData()
        data.append(contentsOf: entities.getconvertedRecipes())
        //fetches.search(q: "chicken")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.reloadData()
    }
    
    @objc func reload(notification: NSNotification){
        //data.append(contentsOf: fetches.data)
        data = fetches.data
        
        DispatchQueue.main.async {
            print(self.data.count)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")! as! CustomRecipeCell
        cell.recipeTitle.text = data[indexPath.row].name
        cell.recipeDetails.text = data[indexPath.row].summary
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

