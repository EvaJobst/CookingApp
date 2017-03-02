//
//  APIManager.swift
//  CookingApp
//
//  Created by Eva Jobst on 01.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

//http://www.kraftfoods.com/ws/RecipeWS.asmx
//https://spoonacular.com/food-api
//https://developer.campbellskitchen.com/documentation/methods#Search
//https://market.mashape.com/webknox/recipe/pricing#!pricing
//http://www.recipebridge.com/api

import Foundation
import Alamofire

class APIManager {
    var api: [API] = []
    var index = 0
    
    init() {
        api.append(API(url: "http://www.weeatt.com/api/v1/recipes"))
        api.last?.parameter = ["qs" : ""]
        api.last?.encoding = URLEncoding.default
        api.last?.header = ["Accept": "application/json",
                            "Content-Type": "application/json",
                            "x-api-key" : "1941ed8ddbb0"]
        
        api.append(API(url: "https://api.edamam.com/search"))
        api.last?.parameter = ["q" : "",
                               "app_key" : "e2ec443fc69c0f7a9907691827737386",
                               "app_id" : "df82cb8f"]
        api.last?.encoding = URLEncoding.default
        
        api.append(API(url: "http://food2fork.com/api/search"))
        api.last?.parameter = ["q" : "",
                               "key" : "5783c7973fbd307c416b10840d55d749"]
        api.last?.encoding = URLEncoding.default
    }
}

class API {
    var url: String
    var parameter : Parameters = [:]
    var header : HTTPHeaders = [:]
    var encoding : ParameterEncoding? = nil
    
    init(url: String) {
        self.url = url
    }
}
