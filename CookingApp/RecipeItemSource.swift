//
//  RecipeItemSource.swift
//  CookingApp
//
//  Created by Hannes on 05.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeItemSource : NSObject, UIActivityItemSource {
    
    var recipes: [OfflineRecipe] = []
    var news: String = ""
    var url : String = "at.fh-ooe.hgb.mc.ios.recipe"
    
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return recipes
    }
    

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {
        NSLog("Place holder itemForActivity")
        
        if(activityType == UIActivityType.airDrop){
            return recipes
        } else {
            return "My delicious recipes"
        }
    }
    
    
    
    
    
}
