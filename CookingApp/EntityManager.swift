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
    var lists : [List]
    var recipes : [Recipe]
    var tables : [RecipeListTable]
    
    override init() {
        listManager = CoreDataManager(entityName: "List")
        recipeManager = CoreDataManager(entityName: "Recipe")
        tableManager = CoreDataManager(entityName: "RecipeListTable")
        
        recipes = recipeManager.fetchedEntity! as! [Recipe]
        lists = listManager.fetchedEntity! as! [List]
        tables = tableManager.fetchedEntity! as! [RecipeListTable]
        
        super.init()
    }
    
    override func update() {
        listManager.update()
        recipeManager.update()
        tableManager.update()
    }
    
    override func save() {
        listManager.save()
        recipeManager.save()
        tableManager.save()
    }
    
    override func set(listID: Int16, recipeID: Int16) {
        tableManager.set(listID: listID, recipeID: recipeID)
        let element = Int16(lists[Int(listID)].numOfRecipes + 1)
        update(index: Int(listID), entityName: "List", attributeName: "numOfRecipes", element: element)
    }
    
    func update(index: Int, entityName: String, attributeName: String, element: Int16) {
        if(entityName == "List") {
            switch attributeName {
            case "listID" : lists[index].listID = element; break
            case "numOfRecipes" : lists[index].numOfRecipes = element;
            default: break
                
            }
            
            listManager.save()
            listManager.update()
            lists = listManager.fetchedEntity as! [List]
        }
            
        else if(entityName == "Recipe") {
            switch attributeName {
            case "recipeID" : recipes[index].recipeID = element; break
            default: break
            }
            
            recipeManager.save()
            recipeManager.update()
        }
            
        else if(entityName == "Table") {
            switch attributeName {
            case "listID" : tables[index].listID = element; break
            case "recipeID" : tables[index].recipeID = element; break
            default: break
            }
            
            tableManager.save()
            tableManager.update()
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
            
        else if(entityName == "Recipe") {
            switch attributeName {
            case "label" : recipes[index].label = element; break
            case "image" : recipes[index].image = element; break
            case "summary" : recipes[index].summary = element; break
            default: break
            }
            
            recipeManager.save()
            recipeManager.update()
        }
    }
    
    func feedingDummyData() {
        // RECIPES
        recipeManager.set(recipeID: 0, label: "Recipe 1", summary: "A very tasty cookie!", image: "cheesecake.jpg")
        
        recipeManager.set(recipeID: 1, label: "Recipe 2", summary: "This might probably be the most beautiful cheesecake I have ever had the chance to encounter. Magnificent! Brilliant! Astonishing!", image: "cheesecake.jpg")
        
        recipeManager.set(recipeID: 2, label: "Recipe 3", summary: "This spaghetti with seafood makes you think of a venetian summer night like you have never before.", image: "cheesecake.jpg")
        
        recipes = recipeManager.fetchedEntity as! [Recipe]
        
        // LISTS
        listManager.set(listID: 0, numOfRecipes: 0, name: "Favorite desserts")
        listManager.set(listID: 1, numOfRecipes: 0, name: "Inspiration")
        listManager.set(listID: 2, numOfRecipes: 0, name: "For the next dinner party")
        listManager.set(listID: 3, numOfRecipes: 0, name: "Best cakes")
        
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
        
        recipes = recipeManager.fetchedEntity as! [Recipe]
        lists = listManager.fetchedEntity as! [List]
        tables = tableManager.fetchedEntity as! [RecipeListTable]
    }
}
