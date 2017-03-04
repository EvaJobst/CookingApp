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
        //fetches.data[indexPath.row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelAction(_ sender: Any) {
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
