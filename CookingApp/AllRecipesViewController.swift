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
    
    
    let fetchKey = "FinishedFetchingRecipes"
    let fetches = FetchManager()
    var data : [RecipeObject] = []
    let entities = EntityManager()
    var switchView : Bool = false
    var nextView : String = ""
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
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
        if switchView {
            
            switchView = false
            
            print("HALLOOOOOO")
            
            if (nextView == "list") {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeLists") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
            }
            else if (nextView == "new") {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "New Recipe") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
            }
            
           

        }
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
        
        menuButton.image = UIImage(named: "menu-button")
        menuButton.accessibilityFrame = CGRect(x: 0, y: 0, width: 16, height: 32)
        menuButton.width = 32
        menuButton.title = ""
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

