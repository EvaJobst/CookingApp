//
//  AddRecipeToListViewController.swift
//  CookingApp
//
//  Created by Hannes on 02.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class AddRecipeToListViewController: UITableViewController, UISearchBarDelegate {
    let keys = ObserverKeyManager()
    let fetches = FetchManager()
    let entities = EntityManager()
    let searches = SearchManager()
    var data : [RecipeObject] = []
    var listID : Int16 = 0
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self

        self.tableView.register(UINib (nibName: "CustomRecipeCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reload),
            name: Notification.Name(rawValue: keys.search),
            object: nil)
        
        data = entities.getconvertedRecipes()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.reloadData()
    }
    
    @objc func reload(notification: NSNotification){
        switch searchBar.selectedScopeButtonIndex {
        case 0 :
            data = searches.data
            break
        case 1 :
            if(searches.actualPage <= 1) {
                data = (searches.fetches?.data)!
            }
            else {
                data.append(contentsOf: (searches.fetches?.data)!)
            }
            break
        default: break
        }
        
        DispatchQueue.main.async {
            print(self.data.count)
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searches.search(entities: entities, fetches: fetches, scope: searchBar.selectedScopeButtonIndex, searchText: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searches.search(entities: entities, fetches: fetches, scope: searchBar.selectedScopeButtonIndex, searchText: searchBar.text!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.data.count - 1 {
            if(searches.actualPage >= 1 && searchBar.selectedScopeButtonIndex == 1 && data.count > 0) {
                searches.actualPage = searches.actualPage + 1
                searches.filterContents()
            }
        }
        
        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")! as! CustomRecipeCell
        cell.recipeTitle.text = data[indexPath.row].name
        cell.recipeDetails.text = data[indexPath.row].summary
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var recipeID : Int16 = 0
        var listID : Int16 = 0
        
        if(searchBar.selectedScopeButtonIndex == 0) {
            recipeID = entities.getRecipeID(source: data[indexPath.row].offlineID)
            listID = self.listID
        }
        
        else { // scope == 1 -> Online
            recipeID = entities.getRecipeID(source: data[indexPath.row].permalink)
            listID = self.listID
            
            if(recipeID == Int16(INT16_MIN)) {
                if(entities.indices.count == 0) {
                    recipeID = 0
                }
                
                else {
                    recipeID = (entities.indices.last?.recipeID)!+1
                }

                entities.indexManager.set(recipeID: recipeID, isOffline: false, source: data[indexPath.row].permalink)
                entities.updateObjects()
            }
        }
        
        if(!entities.set(listID: listID, recipeID: recipeID)) {
            view.makeToast("Recipe is already in this list!")
        }
        
        else {
            view.makeToast("Added Recipe to list!")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.newRecipeInList)), object: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    

    //@IBAction func SearchAction(_ sender: Any) {
    //}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
