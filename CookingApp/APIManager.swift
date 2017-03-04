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
    var url: String = "http://www.weeatt.com/api/v1/recipes"
    var parameter : Parameters = ["qs" : "", "page" : "0"]
    var header : HTTPHeaders = ["Accept": "application/json",
                                "Content-Type": "application/json",
                                "x-api-key" : "1941ed8ddbb0"]
    var encoding : ParameterEncoding? = URLEncoding.default
}
