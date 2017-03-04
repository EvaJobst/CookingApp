//
//  MainMenuController.swift
//  CookingApp
//
//  Created by Hannes on 03.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class MainMenuController: UINavigationController, MenuTransitionManagerDelegate {

    
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

        menuButton.image = UIImage(named: "menu-button")
        menuButton.accessibilityFrame = CGRect(x: 0, y: 0, width: 16, height: 32)
        menuButton.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        menuTableViewController.currentItem = menuTableViewController.nameOfCurrentList
        menuTableViewController.transitioningDelegate = self.menuTransitionManager
        menuTransitionManager.delegate = self
        
    }



    
}
