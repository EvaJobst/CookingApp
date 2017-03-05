//
//  RecipeOverviewViewController.swift
//  CookingApp
//
//  Created by Hannes on 05.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeOverviewViewController: UIViewController, MenuTransitionManagerDelegate {

    var menuButton : UIButton? = nil
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ingredientsLable: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var name : String = ""
    var author : String = ""
    var summary : String = ""
    var ingredients : String = ""
    var instructions : String = ""
    
    var recipe : RecipeObject? = nil
    
    var menuTransitionManager = MenuTransitionManager()
    
    var switchView = false
    var nextView = ""
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuButton?.setBackgroundImage(UIImage(named: "menu-button"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)
        
        nameLabel.text = name
        
        nameLabel.numberOfLines = 3
        nameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        var font = UIFont(name: "Helvetica", size: 30.0)
        nameLabel.font = font
        nameLabel.sizeToFit()
        
        instructionsLabel.text = instructions
        instructionsLabel.numberOfLines = 40
        instructionsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        font = UIFont(name: "Helvetica", size: 20.0)
        instructionsLabel.font = font
        instructionsLabel.sizeToFit()
        
        summaryLabel.text = summary
        summaryLabel.numberOfLines = 10
        summaryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        summaryLabel.font = font
        summaryLabel.sizeToFit()
        
        ingredientsLable.text = ingredients
        ingredientsLable.numberOfLines = 40
        ingredientsLable.lineBreakMode = NSLineBreakMode.byWordWrapping
        ingredientsLable.font = font
        ingredientsLable.sizeToFit()
        
        authorLabel.text = author
        authorLabel.numberOfLines = 1
        authorLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        font = UIFont(name: "Helvetica", size: 10.0)
        authorLabel.font = font
        authorLabel.sizeToFit()
        
        
        let heigth = ingredientsLable.bounds.size.height + instructionsLabel.bounds.size.height
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: heigth)
        
        recipe = RecipeObject(name: name, ingredients: ingredients, instructions: instructions, summary: summary, author: author)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! MainMenuTableViewController
        self.title = sourceController.title
        
        if (sourceController.currentItem == "Cookbook") {
            switchView = true
            nextView = "all"
        }
        else if (sourceController.currentItem == "Share") {
            switchView = true
            nextView = "share"
        }
        else if (sourceController.currentItem == "Your Lists") {
            switchView = true
            nextView = "list"
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
            else if (nextView == "share") {
                
                guard let recipe = recipe,
                    let url = recipe.exportToFileURL() else {
                        return
                }
                
                let activityViewController = UIActivityViewController(
                    activityItems: ["Check out this recipe.", url],
                    applicationActivities: nil)
                
                present(activityViewController, animated: true, completion: nil)
                
                
            }
            else if nextView == "all" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllRecipe") as! UINavigationController
                self.present(nextViewController, animated:true, completion:nil)
                
            }
        }
    }

    func menu(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "mainMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainMenu"{
            let menuTableViewController = segue.destination as! MainMenuTableViewController
            
            menuTableViewController.action = "Share"
            menuTableViewController.recipeName = nameLabel.text!
            menuTableViewController.currentItem = menuTableViewController.recipeName
            menuTableViewController.transitioningDelegate = self.menuTransitionManager
            menuTransitionManager.delegate = self
        }
    }
    
    
}
