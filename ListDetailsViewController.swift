//
//  ListDetailsView.swift
//  CookingApp
//
//  Created by Eva Jobst on 25.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit

class ListDetailsViewController: UITableViewController, MenuTransitionManagerDelegate {
    
    var selectedListID : Int16 = 0
    var row : Int = 0
    var data : [OfflineRecipe] = []
    let entities = EntityManager()
    var menuButton : UIButton? = nil
    var switchView : Bool = false
    var nextView : String = ""
    
    var menuTransitionManager = MenuTransitionManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if switchView {
            
            switchView = false
            
            if nextView == "add" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addRecipeLists") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
            }
            else if nextView == "all" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllRecipe") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
                
            }
            else if nextView == "share" {
               
                
                let objectsToShare = data
                
                    
                let activityController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                let excludedActivities = [UIActivityType.postToFlickr, UIActivityType.postToWeibo, UIActivityType.message, UIActivityType.mail, UIActivityType.print, UIActivityType.copyToPasteboard, UIActivityType.assignToContact, UIActivityType.saveToCameraRoll, UIActivityType.addToReadingList, UIActivityType.postToFlickr, UIActivityType.postToVimeo, UIActivityType.postToTencentWeibo]
                    
                activityController.excludedActivityTypes = excludedActivities
                present(activityController, animated: true, completion: nil)
                
                
            }
        }
        menuButton?.addTarget(self, action: #selector(menu(_:)), for: .touchUpInside)
        
    }
    
    func fileToURL(file: String) -> URL? {
        // Get the full path of the file
        let fileComponents = file.components(separatedBy: ".")
        
        if let filePath = Bundle.main.path(forResource: fileComponents[0], ofType: fileComponents[1]) {
            return URL(fileURLWithPath: filePath)
        }
        
        return nil
    }
    
    
    func menu(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "mainMenu", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = getRecipes()
        self.tableView.register(UINib (nibName: "CustomRecipeCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        tableView.rowHeight = 100
        tableView.reloadData()
        
        
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuButton?.setBackgroundImage(UIImage(named: "menu-button"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)

        
    }
    
    
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! RecipeListsMenuTableViewController
        self.title = sourceController.title
        
        switchView = true
        if (sourceController.currentItem == "Add Recipe") {
            nextView = "add"
        }
        else if (sourceController.currentItem == "Share") {
            nextView = "share"
        }
        else if (sourceController.currentItem == "Settings") {
            nextView = "settings"
        }
        else if (sourceController.currentItem == "Cookbook") {
            nextView = "all"
            
        }
        else if (sourceController.currentItem == "Your Lists") {
            print("Your Lists")
            self.dismiss()
        }
        else {
            nextView = ""
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let menuTableViewController = segue.destination as! RecipeListsMenuTableViewController
        
        menuTableViewController.nameOfCurrenteList = entities.lists[row].name!
        menuTableViewController.currentItem = menuTableViewController.nameOfCurrenteList
        menuTableViewController.transitioningDelegate = self.menuTransitionManager
        menuTransitionManager.delegate = self
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")! as! CustomRecipeCell
        cell.recipeTitle.text = data[indexPath.row].name
        cell.recipeDetails.text = data[indexPath.row].yield.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRecipes () -> [OfflineRecipe] {
        var retRecipes : [OfflineRecipe] = []
        
        for i in 0..<entities.tables.count {
            if(entities.tables[i].listID == selectedListID) {
                retRecipes.append(entities.recipes[Int(entities.tables[i].recipeID)])
            }
        }
        
        return retRecipes
    }
    
}
