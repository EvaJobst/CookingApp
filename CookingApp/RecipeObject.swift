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
}
