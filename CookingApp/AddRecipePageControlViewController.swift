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
    var general : GeneralInformationViewController? = nil
    var ingredients : AddIngriedientViewController? = nil
    var instructions : InstructionViewController? = nil
    
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
                general = child as! GeneralInformationViewController
            }
        }
    }
    
    func saveRecipe() {
        print(general?.nameTextField.text)
        //let name = general?.nameTextField
        //let servings = general?.servingsTextField
        //let summary = general?.summaryTextField
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
