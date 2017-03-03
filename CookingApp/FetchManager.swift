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
    let fetchKey = "FinishedFetchingRecipes"
    let manager = APIManager()
    var query : String = ""
    var data : [RecipeObject] = []
    
    init() {}
    
    func search(q : String) {
        let api = manager.api[manager.index]
        
        if(manager.index == 0) { //weeat requires user to signin first before fetch
            signIn()
        }
        
        query = q
        
        api.parameter[(api.parameter.first?.key)!] = q
            
            Alamofire.request(api.url, method: .get, parameters: api.parameter, encoding: api.encoding!, headers: api.header).responseSwiftyJSON { response in
                self.data.removeAll()
                self.query = q
                
                let recipesJSON = response.result.value?["results"]
                for recipeJSON in recipesJSON! {
                    self.data.append(RecipeObject(jsonData: recipeJSON.1)!)
                }
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.fetchKey)), object: self)
            }

    }
    
    func fetch(recipeID: Int16) {
        
    }
    
    
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
