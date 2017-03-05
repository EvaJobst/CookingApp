//
//  APIManager.swift
//  CookingApp
//
//  Created by Eva Jobst on 01.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    let search : API = API()
    let fetch : API = API()
    let login : API = API()
    
    
    init() {
        search.url = "http://www.weeatt.com/api/v1/recipes"
        search.parameter = ["qs" : "", "page" : "0"]
        
        fetch.url = "http://www.weeatt.com/api/v1/recipes/"
        fetch.parameter = ["permalink" : ""]
    }
    
    func resetFetch() {
        fetch.url = getBaseFetchURL()
    }
    
    func getBaseFetchURL() -> String {
        return "http://www.weeatt.com/api/v1/recipes/"
    }
}

class API {
    var url = ""
    var parameter : Parameters = [:]
    let header : HTTPHeaders = ["Accept": "application/json",
                                "Content-Type": "application/json",
                                "x-api-key" : "1941ed8ddbb0"]
    let encoding : ParameterEncoding? = URLEncoding.default
}
