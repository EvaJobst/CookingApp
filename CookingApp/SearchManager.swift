//
//  SearchManager.swift
//  CookingApp
//
//  Created by Eva Jobst on 04.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit

class SearchManager : UIViewController, UISearchBarDelegate {
    let keys = ObserverKeyManager()
    var entities : EntityManager? = nil
    var fetches : FetchManager? = nil
    var data : [RecipeObject] = []
    var actualPage = 1
    var scope = 0
    var searchText = ""
    
    func search(entities : EntityManager, fetches : FetchManager, scope : Int, searchText : String) {
        if(searchText != "") {
            actualPage = 1
            data.removeAll()
            
            self.fetches = fetches
            self.entities = entities
            self.scope = scope
            self.searchText = searchText
            
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(UIWebView.reload), object: nil)
            self.perform(#selector(self.filterContents), with: nil, afterDelay: 0.5)
        }
    }

    func filterContents() {
        switch scope {
        case 0 :
            data = getFittingRecipes()
            NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.search)), object: self)
            break
        case 1 :
            if((actualPage <= (fetches?.totalPages)!) || actualPage == 1) {
                fetches?.search(q: searchText, page: actualPage)
            }
            break
        default : break
        }
    }
    
    func getFittingRecipes() -> [RecipeObject] {
        var recipes : [RecipeObject] = []
        
        for recipe in (entities?.getconvertedRecipes())! {
            let name = recipe.name.uppercased()
            
            if(name.contains(searchText.uppercased())) {
                recipes.append(recipe)
            }
        }
        
        return recipes
    }
}
