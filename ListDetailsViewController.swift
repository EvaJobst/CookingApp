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
    let entities = EntityManager()
    let keys = ObserverKeyManager()
    let fetches = FetchManager()
    
    var selectedListID : Int16 = 0
    var row : Int = 0
    var data : [RecipeObject] = []
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
                
                let addRecipeToList = nextViewController.viewControllers[0] as! AddRecipeToListViewController
                addRecipeToList.listID = selectedListID                
                self.present(nextViewController, animated:true, completion:nil)
            }
            else if nextView == "all" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllRecipe") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
                
            }
            else if nextView == "share" {
               
                
                // TO DO SHARE
                
                
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
        //data = getRecipes()
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuButton?.setBackgroundImage(UIImage(named: "menu-button"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reload),
            name: Notification.Name(rawValue: keys.newRecipeInList),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadAfterFetch),
            name: Notification.Name(rawValue: keys.fetchForList),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.nextToUpdate),
            name: Notification.Name(rawValue: keys.next),
            object: nil)
        
        updateRecipes()
        self.tableView.register(UINib (nibName: "CustomRecipeCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        tableView.rowHeight = 100
        tableView.reloadData()
    }
    
    @objc func reload(notification: NSNotification){
        entities.updateObjects()
        updateRecipes()
        //data = getRecipes()
        tableView.reloadData()
    }
    
    @objc func reloadAfterFetch(notification: NSNotification){
        data.append(fetches.data[0])
        tableView.reloadData()
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
        
        menuTableViewController.nameOfCurrentList = entities.lists[row].name!
        menuTableViewController.currentItem = menuTableViewController.nameOfCurrentList
        menuTableViewController.transitioningDelegate = self.menuTransitionManager
        menuTransitionManager.delegate = self
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            var recipeID : Int16
            
            if(data[indexPath.row].permalink == "") {
                recipeID = entities.getRecipeID(source: data[indexPath.row].offlineID)
            }
            
            else {
                recipeID = entities.getRecipeID(source: data[indexPath.row].permalink)
            }
           
            let table = entities.getTableEntry(listID: selectedListID, recipeID: recipeID)
            print(table.recipeID)
            print(table.listID)
            entities.delete(entity: table)
            
            entities.updateObjects()
            updateRecipes()
            
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRecipes () {
        data.removeAll()
        var recipesInList : [RecipeListTable] = []
        
        for table in entities.tables {
            if(table.listID == selectedListID) {
                recipesInList.append(table)
            }
        }
        
        if(recipesInList.count > 0) {
            let dictObject = ["recipesInList" : recipesInList, "index" : 0] as [String : Any]
            NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.next)), object: dictObject)
        }
    }
    
    @objc func nextToUpdate(notification: NSNotification){
        var dictObject = notification.object as! [String : Any]
        let index = dictObject["index"] as! Int
        let recipesInList = dictObject["recipesInList"] as! [RecipeListTable]
        
        print(index.description)
        
        entities.updateObjects()
        tableView.reloadData()
        
        if(index < recipesInList.count) {
            let recipeID = recipesInList[index].recipeID
            let listID = recipesInList[index].listID
            let indexElement = entities.indices[Int(recipeID)]
            
            if(indexElement.isOffline) {
                data.append(RecipeObject(data: entities.recipes[Int(indexElement.source!)!]))
                dictObject["index"] = index + 1
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.next)), object: dictObject)
            }
                
            else {
                fetches.fetch(recipeID: recipeID, dictObject: dictObject)
                //NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.next)), object: (index+1))
            }
        }
    }
}
