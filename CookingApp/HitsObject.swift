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

class HitsObject {
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
}

class RecipeObject {
    let label : String
    let image : String
    let yield : Int16
    let summary : String
    let level : String
    let recipeID : Int16
    
    init?(jsonData:JSON){
        let jsonRecipe = jsonData["recipe"]
        
        label = jsonRecipe["label"].stringValue
        image = jsonRecipe["image"].stringValue
        yield = jsonRecipe["yield"].int16Value
        summary = jsonRecipe["summary"].stringValue
        level = jsonRecipe["level"].stringValue
        recipeID = 0
    }
}

// RecipeSource
// recipeID
// source

/*
 id
 
 
*/

/*
 WE EAT
 images : [String]
 ingredients : String \r\n
 id : Int
 instructions : String \r\n
 description : String
 name : String
 chef -> name : String
 */

/*
 YUMMLY
 rating : String
 ingredientLines : [String]
 images
 name
 numberOfServings
 source -> sourceRecipeUrl
 source -> id
 */
