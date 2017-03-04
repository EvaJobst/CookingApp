//
//  AllRecipesView.swift
//  CookingApp
//
//  Created by Eva Jobst on 09.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit
import Alamofire

class AllRecipesViewController: UITableViewController, MenuTransitionManagerDelegate, UISearchBarDelegate {
    let keys = ObserverKeyManager()
    let fetches = FetchManager()
    let entities = EntityManager()
    let searches = SearchManager()
    var data : [RecipeObject] = []
    @IBOutlet weak var searchBar: UISearchBar!
    var switchView : Bool = false
    var nextView : String = ""
    var menuButton : UIButton? = nil
    var menuTransitionManager = MenuTransitionManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! MainMenuTableViewController
        self.title = sourceController.title
        
        if (sourceController.currentItem == "Settings") {
            print("SETTINGS")
        }
        else if (sourceController.currentItem == "Your Lists") {
            switchView = true
            nextView = "list"
        }
        else if (sourceController.currentItem == "New Recipe") {
            nextView = "new"
            switchView = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        menuButton?.addTarget(self, action: #selector(menu(_:)), for: .touchUpInside)
        
        if switchView {
            
            switchView = false
            
            if (nextView == "list") {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeLists") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
            }
            else if (nextView == "new") {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "newRecipe") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
    }
    
    func menu(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "mainMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let menuTableViewController = segue.destination as? MainMenuTableViewController {
            menuTableViewController.currentItem = "Cookbook"
            menuTableViewController.action = "New Recipe"
            menuTableViewController.transitioningDelegate = self.menuTransitionManager
            menuTransitionManager.delegate = self
        }
        
    }
    
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
        
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuButton?.setBackgroundImage(UIImage(named: "menu-button"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

