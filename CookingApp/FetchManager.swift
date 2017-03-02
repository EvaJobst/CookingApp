//
//  FetchManager.swift
//  CookingApp
//
//  Created by Eva Jobst on 28.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON

class FetchManager {
    let manager = APIManager()
    var query : String = ""
    var hasMore : Bool = false
    
    init() {}
    
    func fetch(q : String) -> [RecipeObject] {
        var recipes : [RecipeObject] = []
        let api = manager.api[manager.index]
        
        if(manager.index == 1) { //weeat requires user to signin first before fetch
            signIn()
        }
        
        query = q
        api.parameter[(api.parameter.first?.key)!] = query
        
        Alamofire.request(api.url, method: .get, parameters: api.parameter, encoding: api.encoding!, headers: api.header).responseSwiftyJSON { response in
            print(response.debugDescription)
            //let model : HitsModel = HitsModel(jsonData: response.result.value!, index: self.manager.index)!
            //recipes.append(contentsOf: model.recipes)
            print(response.result.value)
        }
        
        return recipes
    }
    
    /*func more() -> [RecipeObject] {
        if(hasMore) {
            //from = from + 10
            //to = to + 10
            return fetch(q: query)
        }
        
        let recipes : [RecipeObject] = []
        return recipes
    }*/
    
    /**
     Necessary to sign in before using api
     */
    func signIn() {
        //ALAMOFIRE REQUEST
        
        let parameter : Parameters = ["chef_login" : ["login" : "EvaJobst", "password" : "123456"]]
        
        let header : HTTPHeaders = ["Accept": "application/json",
                                    "Content-Type": "application/json",
                                    "x-api-key" : "1941ed8ddbb0"]
        
        Alamofire.request("http://www.weeatt.com/api/v1/chefs/sign_in", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON {response in
            
            if let JSON = response.result.value {}
        }
    }
}
