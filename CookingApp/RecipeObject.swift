//
//  HitsModel.swift
//  CookingApp
//
//  Created by Eva Jobst on 28.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/*class HitsObject {
    let q : String
    let from : Int
    let to : Int
    let count : Int
    let more : Bool
    var recipes : [RecipeObject]
    
    init?(jsonData:JSON, index: Int){
        recipes = []
        
        self.q = jsonData["q"].stringValue
        self.from = jsonData["from"].intValue
        self.to = jsonData["to"].intValue
        self.count = jsonData["count"].intValue
        self.more = jsonData["more"].boolValue
        
        for hit in jsonData["hits"].array! {
            self.recipes.append(RecipeObject(jsonData: hit)!)
        }
    }
}*/

class RecipeObject {
    let offlineID : Int16
    let name : String
    let ingredients : String
    let instructions : String
    let yield : Int16
    let summary : String
    let author : String
    let permalink : String
    
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
    
    init(data : OfflineRecipe) {
        offlineID = data.offlineID
        name = data.name!
        ingredients = data.ingredients!
        instructions = data.instructions!
        yield = data.yield
        summary = data.summary!
        author = data.author!
        
        if(offlineID == Int16(INT16_MIN)) {
            permalink = data.permalink!
        }
        
        else {
            permalink = ""
        }
    }
    
    init(name: String, ingredients: String, instructions: String, summary: String, author: String) {
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.summary = summary
        self.author = author
        self.yield = 0
        self.permalink = ""
        self.offlineID = 0
    }
    
    init?(jsonData:JSON){
        name = jsonData["name"].stringValue
        yield = jsonData["yield"].int16Value
        summary = jsonData["description"].stringValue
        author = jsonData["chef"]["name"].stringValue
        ingredients = jsonData["ingredients"].stringValue
        instructions = jsonData["instructions"].stringValue
        permalink = jsonData["permalink"].stringValue
        offlineID = Int16(INT16_MIN)
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
    
    
    func exportToFileURL() -> URL? {
        
        let contents: [String : Any] = [Keys.author.rawValue: author, Keys.ingredients.rawValue: ingredients, Keys.instructions.rawValue: instructions, Keys.name.rawValue: name, Keys.summary.rawValue: summary]
    
        
        guard let path = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
        }
        
        
        let saveFileURL = path.appendingPathComponent("/\(name).recipe")
        (contents as NSDictionary).write(to: saveFileURL, atomically: true)
        return saveFileURL
    }
}
