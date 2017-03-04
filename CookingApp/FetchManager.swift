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
    let keys = ObserverKeyManager()
    let api = APIManager()
    var data : [RecipeObject] = []
    var totalPages : Int = 0
    var actualPage : Int = 0
    var query : String = ""
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.request),
            name: Notification.Name(rawValue: keys.authentification),
            object: nil)
    }
    
    func search(q : String, page : Int) {
        if(!q.isEmpty) {
            query = q
            actualPage = page
            //signIn()
            
            let parameter : Parameters = ["chef_login" : ["login" : "EvaJobst", "password" : "123456"]]
            
            let header : HTTPHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json",
                                        "x-api-key" : "1941ed8ddbb0"]
            
            Alamofire.request("http://www.weeatt.com/api/v1/chefs/sign_in", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON {response in
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.authentification)), object: self)
            }
        }
    }
    
    @objc func request(notification: NSNotification) {
        if(actualPage != 0 && !query.isEmpty) {
            api.parameter["qs"] = query
            api.parameter["page"] = actualPage.description
            
            Alamofire.request(api.url, method: .get, parameters: api.parameter, encoding: api.encoding!, headers: api.header).responseSwiftyJSON { response in
                self.data.removeAll()
                
                //print(response.request.debugDescription)
                //print(response.response.debugDescription)
                
                self.totalPages = (response.result.value?["total_pages"].intValue)!
                print(response.result.debugDescription)
                
                let recipesJSON = response.result.value?["results"]
                for recipeJSON in recipesJSON! {
                    self.data.append(RecipeObject(jsonData: recipeJSON.1)!)
                }
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.search)), object: self)
            }

        }
    }
    
    func fetch(recipeID: Int16) {
        
    }
    
    /**
     Necessary to sign in before using api
     */
    func signIn() {
        
    }
}
