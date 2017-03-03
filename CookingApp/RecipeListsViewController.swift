//
//  RecipeListsView.swift
//  CookingApp
//
//  Created by Eva Jobst on 25.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeListsViewController: UITableViewController, MenuTransitionManagerDelegate {
    let newListKey = "NewListInDatabase"
    var entities : EntityManager? = nil
    var selectedListID : Int16 = 0
    var indexOfSelectedElement = 0
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
        else if (sourceController.currentItem == "Cookbook") {
            print("COOKBOOK")
            switchView = true
            nextView = "all"
        }
        else if (sourceController.currentItem == "New List") {
            switchView = true
            nextView = "new"
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if switchView {
            
            switchView = false 
            
            if nextView == "new" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "newList") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
            
            }
            else if nextView == "all" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllRecipe") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
                
            }
        }

        
       menuButton?.addTarget(self, action: #selector(menu(_:)), for: .touchUpInside)
        
    }
    
    func menu(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "mainMenu", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entities = EntityManager()
        tableView.reloadData()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reload),
            name: Notification.Name(rawValue: newListKey),
            object: nil)
        
        nextView = ""
        
        
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuButton?.setBackgroundImage(UIImage(named: "menu-button"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
    }
    
    @objc func reload(notification: NSNotification){
        entities?.updateObjects()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities!.lists.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        cell.textLabel?.text = entities?.lists[indexPath.row].name
        cell.detailTextLabel?.text = (entities?.lists[indexPath.row].count.description)! + " recipes"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            print("delete")
            entities?.listManager.delete(entity: (entities?.lists[indexPath.row])!)
            entities?.updateObjects()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedListID = Int16(indexPath.row)
        indexOfSelectedElement = indexPath.row
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            if let viewInstance = segue.destination as? UINavigationController {
                
                if let view = viewInstance.viewControllers.first as? ListDetailsViewController {
                    view.row = indexOfSelectedElement
                    view.selectedListID = selectedListID
                }
                
            }
        }
        else {
            let menuTableViewController = segue.destination as! MainMenuTableViewController
            
            menuTableViewController.currentItem = "Your Lists"
            menuTableViewController.action = "New List"
            menuTableViewController.transitioningDelegate = self.menuTransitionManager
            menuTransitionManager.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

