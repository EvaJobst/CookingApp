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
    let authentificationKey = "FinishedAuthentification"
    let fetchKey = "FinishedFetchingRecipes"
    let manager = APIManager()
    var data : [RecipeObject] = []
    var totalPages : Int = 0
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.request),
            name: Notification.Name(rawValue: authentificationKey),
            object: nil)
    }
    
    func search(q : String, page : Int) {
        manager.api.parameter["qs"] = q
        manager.api.parameter["page"] = page.description
        signIn()
    }
    
    @objc func request(notification: NSNotification) {
        Alamofire.request(manager.api.url, method: .get, parameters: manager.api.parameter, encoding: manager.api.encoding!, headers: manager.api.header).responseSwiftyJSON { response in
            self.data.removeAll()
            
            self.totalPages = (response.result.value?["total_results"].intValue)! / (response.result.value?["per_page"].intValue)!
            
            if((response.result.value?["total_results"].intValue)! % (response.result.value?["per_page"].intValue)! == 0) {
                self.totalPages = self.totalPages + 1
            }
            
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
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: (self.authentificationKey)), object: self)
        }
    }
}
