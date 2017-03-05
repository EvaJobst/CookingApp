//
//  AddRecipePageControlViewController.swift
//  CookingApp
//
//  Created by Hannes on 27.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class AddRecipePageControlViewController: UIViewController {
    let entities = EntityManager()
    var generalViewController : GeneralInformationViewController? = nil
    var ingredientsViewController : AddIngriedientViewController? = nil
    var instructionsViewController : InstructionTableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*@IBAction func addRecipe(_ sender: Any) {
    
        // TO DO ADD RECIPE
    }*/
    
    @IBAction func saveAction(_ sender: Any) {
        getController()
        saveRecipe()
        self.dismiss(animated: true, completion: nil)
    }
    
    func getController() {
        let controller = self.navigationController!.viewControllers[0].childViewControllers[0].childViewControllers
        
        for child in controller as Array {
            if(child is GeneralInformationViewController) {
                generalViewController = child as! GeneralInformationViewController
            }
            
            else if(child.childViewControllers[0] is InstructionTableViewController) {
                instructionsViewController = child.childViewControllers[0] as! InstructionTableViewController
            }
            
            else if(child.childViewControllers[0] is AddIngriedientViewController) {
                ingredientsViewController = child.childViewControllers[0] as! AddIngriedientViewController
            }
        }
    }
    
    func saveRecipe() {
        let name = generalViewController?.nameTextField.text!
        let yield = generalViewController?.servingsTextField.text!
        let summary = generalViewController?.summaryTextField.text!
        let ingredients = toString(ingredients: (ingredientsViewController?.items)!)
        let instructions = toString(instructions: (instructionsViewController?.items)!)
        //let author = entities.author[0].name!
        let author = "Dummy Person"
        
        let offlineID = Int16(entities.recipes.count)
        
        entities.indexManager.set(recipeID: Int16(entities.indices.count), isOffline: false, source: offlineID.description)
        entities.recipeManager.set(offlineID: offlineID, name: name!, ingredients: ingredients, instructions: instructions, yield: Int16(yield!)!, author: author, summary: summary!)
    }
    
    func toString(instructions: [Instruction]) -> String {
        var retItems : String = ""
        
        for instruction in instructions {
            retItems = toString(instruction: instruction, retItems: retItems)
        }
        
        print(retItems)
        return retItems
    }
    
    func toString(ingredients: [Ingredient]) -> String {
        var retItems : String = ""
        
        for ingredient in ingredients {
            retItems = toString(ingredient: ingredient, retItems: retItems)
        }
        
        print(retItems)
        return retItems
    }
    
    func toString(instruction: Instruction, retItems: String) -> String {
        var retItem : String = retItems
        retItem += instruction.number.description + ". " + instruction.instruction + "\r\n"
        return retItem
    }
    
    func toString(ingredient: Ingredient, retItems: String) -> String {
        var retItem : String = retItems
        retItem += ingredient.number.description + " " + ingredient.measurement + " " + ingredient.name  + "\r\n"
        return retItem
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
