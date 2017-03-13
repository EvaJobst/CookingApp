//
//  RecipeItemSource.swift
//  CookingApp
//
//  Created by Hannes on 05.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class RecipeList : NSObject {
    
    var recipes: [RecipeObject] = []
    var name : String = ""
    
    
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
        
        let entities = EntityManager()
        var offlineID = entities.recipes.count + 1
        let yield = 0
        
        
        guard let dictionary = NSDictionary(contentsOf: url),
            let recipeInfo = dictionary as? [String: AnyObject] else {
                return
        }
        
        entities.listManager.set(listID: Int16(entities.lists.count), count: Int16(recipeInfo.count), name: recipeInfo["name"] as! String)
        
        for var i in 0...recipeInfo.count {
            if let recipe = recipeInfo["recipe\(i)"] as? [String: AnyObject] {
                entities.recipeManager.set(offlineID: Int16(offlineID), name: recipe[Keys.name.rawValue] as! String, ingredients: recipe[Keys.ingredients.rawValue] as! String, instructions: recipe[Keys.instructions.rawValue] as! String, yield: Int16(yield), author: recipe[Keys.author.rawValue] as! String, summary: recipe[Keys.summary.rawValue] as! String)
                
                entities.listManager.set(listID: Int16(entities.lists.count), recipeID: Int16(offlineID))
                
                offlineID = offlineID + 1
            }
            
        }
       
        
        entities.recipeManager.update()
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Failed to remove item from Inbox")
        }
    }
    
    
    func exportToFileURL() -> URL? {
        
        var contents: [String : Any] = [:]
        var index : Int = 0
        
        contents["name"] = name
        
        for var i in recipes {
            let id = "recipe\(index)"
            index = index + 1
            
            contents[id] = [Keys.author.rawValue: i.author, Keys.ingredients.rawValue: i.ingredients, Keys.instructions.rawValue: i.instructions, Keys.name.rawValue: i.name, Keys.summary.rawValue: i.summary]
            
        }
        
        
        
        guard let path = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
        }
        
        
        let saveFileURL = path.appendingPathComponent("/\(name).recipe")
        (contents as NSDictionary).write(to: saveFileURL, atomically: true)
        return saveFileURL
    }

    
    
    
}
