//
//  AllRecipesView.swift
//  CookingApp
//
//  Created by Eva Jobst on 09.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit
import Alamofire

class AllRecipesViewController: UITableViewController, UISearchBarDelegate {
    let fetchKey = "FinishedFetchingRecipes"
    let fetches = FetchManager()
    var data : [RecipeObject] = []
    @IBOutlet weak var searchBar: UISearchBar!
    let entities = EntityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
        self.tableView.register(UINib (nibName: "CustomRecipeCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reload),
            name: Notification.Name(rawValue: fetchKey),
            object: nil)
        
        entities.deletingDummyData()
        entities.feedingDummyData()
        data.append(contentsOf: entities.getconvertedRecipes())
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.reloadData()
    }
    
    @objc func reload(notification: NSNotification){
        data.append(contentsOf: fetches.data)
        
        DispatchQueue.main.async {
            print(self.data.count)
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(UIWebView.reload), object: nil)
        self.perform(#selector(self.filterContents), with: nil, afterDelay: 0.5)
    }
    
    func filterContents() {
        data.removeAll()
        
        switch searchBar.selectedScopeButtonIndex {
        case 0 :
            data.append(contentsOf: getFittingRecipes(searchText: searchBar.text!))
            fetches.search(q: searchBar.text!)
            break
        case 1 :
            fetches.search(q: searchBar.text!)
            break
        case 2 :
            data.append(contentsOf: getFittingRecipes(searchText: searchBar.text!))
            tableView.reloadData()
            break
        default : break
        }
    }
    
    func getFittingRecipes(searchText: String) -> [RecipeObject] {
        var recipes : [RecipeObject] = []
        
        for recipe in entities.getconvertedRecipes() {
            let name = recipe.name.uppercased()
            
            if(name.contains(searchText.uppercased())) {
                recipes.append(recipe)
            }
        }
        
        return recipes
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

