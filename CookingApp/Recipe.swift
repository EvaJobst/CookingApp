//
//  File.swift
//  CookingApp
//
//  Created by Eva Jobst on 09.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
    public var title : String
    public var details : String
    public var image : UIImage

    init() {
        self.title = ""
        self.details = ""
        self.image = UIImage()
    }
    
    init(title: String, details: String, image: UIImage) {
        self.title = title
        self.details = details
        self.image = image
    }
}
