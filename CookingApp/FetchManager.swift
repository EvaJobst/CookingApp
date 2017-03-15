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
import SwiftyJSON

class FetchManager {
    let keys = ObserverKeyManager()
    let api = APIManager()
    let entities = EntityManager()
    var data : [RecipeObject] = []
    var totalPages : Int = 0
    var actualPage : Int = 0
    var query : String = ""
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.searchRequest),
            name: Notification.Name(rawValue: keys.authentificationSearch),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.fetchRequest),
            name: Notification.Name(rawValue: keys.authentificationFetch),
            object: nil)
    }
    
    func search(q : String, page : Int) {
        if(!q.isEmpty) {
            query = q
            actualPage = page
            signIn(isFetch: false, dictObject: [:])
        }
    }
    
    func signIn(isFetch: Bool, dictObject : [String : Any]) {
        //sign in required before fetching
        let parameter : Parameters = ["chef_login" : ["login" : "EvaJobst", "password" : "123456"]]
        
        let header : HTTPHeaders = ["Accept": "application/json",
                                    "Content-Type": "application/json",
                                    "x-api-key" : "1941ed8ddbb0"]
        
        Alamofire.request("http://www.weeatt.com/api/v1/chefs/sign_in", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON {response in
            //print("Sign In!")
            print(response.response.debugDescription)
            print(response.result.debugDescription)
            
            if(isFetch) {
                //print("To fetch!")
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.authentificationFetch)), object: dictObject)
            }
            
            else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.authentificationSearch)), object: self)
            }
        }
    }
    
    @objc func searchRequest(notification: NSNotification) {
        if(actualPage != 0 && !query.isEmpty) {
            api.search.parameter["qs"] = query
            api.search.parameter["page"] = actualPage.description
            
            Alamofire.request(api.search.url, method: .get, parameters: api.search.parameter, encoding: api.search.encoding!, headers: api.search.header).responseSwiftyJSON { response in
                self.data.removeAll()
                
                self.totalPages = (response.result.value?["total_pages"].intValue)!
                
                let recipesJSON = response.result.value?["results"]
                for recipeJSON in recipesJSON! {
                    self.data.append(RecipeObject(jsonData: recipeJSON.1)!)
                }
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.search)), object: self)
            }
        }
    }
    
    func fetch(recipeID: Int16, dictObject: [String : Any]) {
        
        for index in 0...entities.indices.count-1 {
            if entities.indices[index].recipeID == recipeID {
                if(!entities.indices[index].isOffline && entities.indices[index].source != "") {
                    //api.fetch.url = api.getBaseFetchURL()
                    //api.fetch.url.append(entities.indices[Int(recipeID)].source!)
                    api.fetch.parameter["permalink"] = entities.indices[index].source!
                    signIn(isFetch: true, dictObject : dictObject)
                }
            }
            
        }
        
        
    }
    
    @objc func fetchRequest(notification: NSNotification) {
        data.removeAll()
        if((api.fetch.parameter["permalink"] as! String) != "") {
            var dictObject = notification.object as! [String : Any]
            
            print("URL in request: " + api.fetch.url)
            Alamofire.request(api.fetch.url, method: .get, parameters: api.fetch.parameter, encoding: api.fetch.encoding!, headers: api.fetch.header).responseSwiftyJSON { response in
                let recipeJSON = response.result.value!
                print(recipeJSON)
                self.data.append(RecipeObject(jsonData: recipeJSON["results"][0])!)
                self.api.resetFetch()
                
                let index = dictObject["index"] as! Int
                dictObject["index"] = index + 1
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.next)), object: dictObject)
                NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.fetchForList)), object: self)
            }
        }
        
    }
}
