//
//  RecipeItemSource.swift
//  CookingApp
//
//  Created by Hannes on 05.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeList : NSObject {
    
    var recipes: [OfflineRecipe] = []
    
    
    fileprivate enum Keys: String {
        case offlineID = "offlineID"
        case name = "name"
        case ingredients = "String"
        case instructions = "instructions"
        case yield = "yield"
        case summary = "summary"
        case author = "author"
        case permalink = "permalink"
    }

    
    
    static func importData(from url: URL) {
        
        guard let dictionary = NSDictionary(contentsOf: url),
            let recipeInfo = dictionary as? [String: AnyObject],
            let ingredients = recipeInfo[Keys.ingredients.rawValue] as? String,
            let instructions = recipeInfo[Keys.instructions.rawValue] as? String,
            let summary = recipeInfo[Keys.summary.rawValue] as? String,
            let author = recipeInfo[Keys.author.rawValue] as? String,
            let name = recipeInfo[Keys.name.rawValue] as? String else {
                return
        }
        
        let entities = EntityManager()
        let offlineID = entities.recipes.count + 1
        let yield = 0
        entities.recipeManager.set(offlineID: Int16(offlineID), name: name, ingredients: ingredients, instructions: instructions, yield: Int16(yield), author: author, summary: summary)
        
        entities.recipeManager.update()
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Failed to remove item from Inbox")
        }
    }
    
    
    /*func exportToFileURL() -> URL? {
        
        var contents: [String : Any] = [:]
        var index : Int = 0
        
        for var i in recipes {
            var id = "recipe\(index)"
            index = index + 1
            
            contents[id] = [Keys.author.rawValue: i.author, Keys.ingredients.rawValue: i.ingredients, Keys.instructions.rawValue: i.instructions, Keys.name.rawValue: i.name, Keys.summary.rawValue: i.summary]
            
        }
        
        
        
        guard let path = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
        }
        
        
        /*let saveFileURL = path.appendingPathComponent("/\(name).recipe")
        (contents as NSDictionary).write(to: saveFileURL, atomically: true)
        return saveFileURL*/
    }*/

    
    
    
}
