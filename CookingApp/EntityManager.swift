//
//  EntityManager.swift
//  CookingApp
//
//  Created by Eva Jobst on 26.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EntityManager : CoreDataManager<NSManagedObject> {
    var listManager : CoreDataManager<NSManagedObject>
    var recipeManager : CoreDataManager<NSManagedObject>
    var tableManager : CoreDataManager<NSManagedObject>
    var indexManager : CoreDataManager<NSManagedObject>
    var lists : [List]
    var recipes : [OfflineRecipe]
    var tables : [RecipeListTable]
    var indices : [RecipeIndexManager]
    
    override init() {
        listManager = CoreDataManager(entityName: "List")
        recipeManager = CoreDataManager(entityName: "Recipe")
        tableManager = CoreDataManager(entityName: "RecipeListTable")
        indexManager = CoreDataManager(entityName: "RecipeIndexManager")
        
        recipes = recipeManager.fetchedEntity! as! [OfflineRecipe]
        lists = listManager.fetchedEntity! as! [List]
        tables = tableManager.fetchedEntity! as! [RecipeListTable]
        indices = indexManager.fetchedEntity! as! [RecipeIndexManager]
        
        super.init()
    }
    
    override func update() {
        listManager.update()
        recipeManager.update()
        tableManager.update()
        indexManager.update()
    }
    
    override func save() {
        listManager.save()
        recipeManager.save()
        tableManager.save()
        indexManager.save()
    }
    
    override func set(listID: Int16, recipeID: Int16) {
        tableManager.set(listID: listID, recipeID: recipeID)
        let element = Int16(lists[Int(listID)].count + 1)
        update(index: Int(listID), entityName: "List", attributeName: "count", element: element)
    }
    
    func update(index: Int, entityName: String, attributeName: String, element: Int16) {
        if(entityName == "List") {
            switch attributeName {
            case "listID" : lists[index].listID = element; break
            case "count" : lists[index].count = element;
            default: break
                
            }
            
            listManager.save()
            listManager.update()
            lists = listManager.fetchedEntity as! [List]
        }
            
        else if(entityName == "OfflineRecipe") {
            switch attributeName {
            case "offlineID" : recipes[index].offlineID = element; break
            case "yield" : recipes[index].yield = element; break
            default: break
            }
            
            recipeManager.save()
            recipeManager.update()
            recipes = recipeManager.fetchedEntity as! [OfflineRecipe]
        }
            
        else if(entityName == "RecipeListTable") {
            switch attributeName {
            case "listID" : tables[index].listID = element; break
            case "recipeID" : tables[index].recipeID = element; break
            default: break
            }
            
            tableManager.save()
            tableManager.update()
            tables = tableManager.fetchedEntity as! [RecipeListTable]
        }
        
        else if(entityName == "RecipeIndexManager") {
            switch attributeName {
            case "recipeID" : indices[index].recipeID = element; break
            default : break
            }
            
            indexManager.save()
            indexManager.update()
            indices = indexManager.fetchedEntity as! [RecipeIndexManager]
        }
    }
    
    func update(index: Int, entityName: String, attributeName: String, element: String) {
        if(entityName == "List") {
            switch attributeName {
            case "name" : lists[index].name = element; break
            default: break
            }
            
            listManager.save()
            listManager.update()
            lists = listManager.fetchedEntity as! [List]
        }
            
        else if(entityName == "OfflineRecipe") {
            switch attributeName {
            case "name" : recipes[index].name = element; break
            case "ingredients" : recipes[index].ingredients = element; break
            case "instructions" : recipes[index].instructions = element; break
            case "image" : recipes[index].image = element; break
            case "author" : recipes[index].author = element; break
            case "summary" : recipes[index].summary = element; break
            default: break
            }
            
            recipeManager.save()
            recipeManager.update()
            recipes = recipeManager.fetchedEntity as! [OfflineRecipe]
        }
        
        else if(entityName == "RecipeIndexManager") {
            switch attributeName {
            case "sourceIdx" : indices[index].sourceIdx = element; break
            default: break
            }
            
            indexManager.save()
            indexManager.update()
            indices = indexManager.fetchedEntity as! [RecipeIndexManager]
        }
    }
    
    func update(index: Int, entityName: String, attributeName: String, element: Bool) {
        if(entityName == "RecipeIndexManager") {
            switch attributeName {
            case "isOffline" : indices[index].isOffline = element; break
            default: break
            }
        }
    }
    
    func feedingDummyData() {
        // RECIPES
        recipeManager.set(offlineID: 0, name: "Recipe 1", ingredients: "", instructions: "", image: "cheesecake.jpg", yield: 4, author: "Eva Jobst", summary: "")
        
        recipeManager.set(offlineID: 0, name: "Recipe 1", ingredients: "", instructions: "", image: "cheesecake.jpg", yield: 4, author: "Eva Jobst", summary: "")
        
        recipeManager.set(offlineID: 0, name: "Recipe 1", ingredients: "", instructions: "", image: "cheesecake.jpg", yield: 4, author: "Eva Jobst", summary: "")
        
        recipes = recipeManager.fetchedEntity as! [OfflineRecipe]
        
        // LISTS
        listManager.set(listID: 0, count: 0, name: "Favorite desserts")
        listManager.set(listID: 1, count: 0, name: "Inspiration")
        listManager.set(listID: 2, count: 0, name: "For the next dinner party")
        listManager.set(listID: 3, count: 0, name: "Best cakes")
        
        lists = listManager.fetchedEntity as! [List]
        
        // TABLES
        set(listID: 0, recipeID: 0)
        set(listID: 0, recipeID: 1)
        set(listID: 0, recipeID: 2)
        set(listID: 1, recipeID: 0)
        set(listID: 3, recipeID: 0)
        set(listID: 3, recipeID: 2)
        
        tables = tableManager.fetchedEntity as! [RecipeListTable]
    }
    
    func deletingDummyData() {
        // RECIPES
        for i in 0..<recipes.count {
            recipeManager.delete(entity: recipes[i])
        }
        
        // LISTS
        for i in 0..<lists.count {
            listManager.delete(entity: lists[i])
        }
        
        // TABLES
        for i in 0..<tables.count {
            tableManager.delete(entity: tables[i])
        }
        
        // SAVING
        recipeManager.save()
        recipeManager.update()
        listManager.save()
        listManager.update()
        tableManager.save()
        tableManager.update()
        
        recipes = recipeManager.fetchedEntity as! [OfflineRecipe]
        lists = listManager.fetchedEntity as! [List]
        tables = tableManager.fetchedEntity as! [RecipeListTable]
    }
}
