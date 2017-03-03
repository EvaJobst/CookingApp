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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = getRecipes()
        self.tableView.register(UINib (nibName: "CustomRecipeCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        tableView.rowHeight = 100
        tableView.reloadData()
        
        menuButton.image = UIImage(named: "menu-button")
        menuButton.accessibilityFrame = CGRect(x: 0, y: 0, width: 16, height: 32)
        menuButton.title = ""
        
    }
    
    
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! RecipeListsMenuTableViewController
        self.title = sourceController.title
        
        if (sourceController.currentItem == "Add Recipe") {
            print("Ok, bin in ADD RECIPE")
        }
        else if (sourceController.currentItem == "Share") {
            print("OK BIN IN SHARE")
        }
        else if (sourceController.currentItem == "Settings") {
            print("SETTINGS")
        }
        else if (sourceController.currentItem == "Cookbook") {
            print("COOKBOOK")
            
        }
        else if (sourceController.currentItem == "Your Lists") {
            print("Your Lists")
            self.dismiss()
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
        
        let image : UIImage = UIImage(named: data[indexPath.row].image!)!
        let cell : CustomRecipeCell = self.tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")! as! CustomRecipeCell
        cell.recipeTitle.text = data[indexPath.row].name
        cell.recipeDetails.text = data[indexPath.row].yield.description
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
