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
import Toast_Swift

class EntityManager : CoreDataManager<NSManagedObject> {
    var listManager : CoreDataManager<NSManagedObject>
    var recipeManager : CoreDataManager<NSManagedObject>
    var tableManager : CoreDataManager<NSManagedObject>
    var indexManager : CoreDataManager<NSManagedObject>
    var authorManager : CoreDataManager<NSManagedObject>
    var lists : [List]
    var recipes : [OfflineRecipe]
    var tables : [RecipeListTable]
    var indices : [RecipeIndexManager]
    var author : [Author]
    
    override init() {
        listManager = CoreDataManager(entityName: "List")
        recipeManager = CoreDataManager(entityName: "OfflineRecipe")
        tableManager = CoreDataManager(entityName: "RecipeListTable")
        indexManager = CoreDataManager(entityName: "RecipeIndexManager")
        authorManager = CoreDataManager(entityName: "Author")
        
        recipes = recipeManager.fetchedEntity! as! [OfflineRecipe]
        lists = listManager.fetchedEntity! as! [List]
        tables = tableManager.fetchedEntity! as! [RecipeListTable]
        indices = indexManager.fetchedEntity! as! [RecipeIndexManager]
        author = authorManager.fetchedEntity as! [Author]
        
        super.init()
    }
    
    func printData() {
        print("RECIPES")
        print("Count: " + recipes.count.description)
        
        for recipe in recipes {
            print("Name: " + recipe.name!)
        }
        
        print()
        print("INDICES")
        print("Count: " + indices.count.description)
        
        for index in indices {
            print("Source: " + index.source!)
        }
        
        print()
        print("LISTS")
        print("Count: " + lists.count.description)
        
        for list in lists {
            print("Name: " + list.name!)
        }
        
        print()
        print("TABLES")
        print("Count: " + tables.count.description)
        
        for table in tables {
            print("List: " + table.listID.description + ", Recipe: " + table.recipeID.description)
        }
    }
    
    func removeListObjects(listID: Int16) {
        for table in tables {
            if(table.listID == listID) {
                tableManager.delete(entity: table)
            }
        }
    }
    
    func updateObjects() {
        update()
        recipes = recipeManager.fetchedEntity! as! [OfflineRecipe]
        lists = listManager.fetchedEntity! as! [List]
        tables = tableManager.fetchedEntity! as! [RecipeListTable]
        indices = indexManager.fetchedEntity! as! [RecipeIndexManager]
        author = authorManager.fetchedEntity as! [Author]
    }
    
    func delete(entity: NSManagedObject, listID: Int) {
        tableManager.delete(entity: entity)
        let element = Int16(lists[Int(listID)].count - 1)
        update(index: Int(listID), entityName: "List", attributeName: "count", element: element)

        save()
        updateObjects()
        
        printData()
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
    
    func set(listID: Int16, recipeID: Int16) -> Bool {
        if(!isInList(listID: listID, recipeID: recipeID)) {
            tableManager.set(listID: listID, recipeID: recipeID)
            let element = Int16(lists[Int(listID)].count + 1)
            update(index: Int(listID), entityName: "List", attributeName: "count", element: element)
            return true
        }
        
        else {
            return false
        }
    }
    
    func update(index: Int, entityName: String, attributeName: String, element: Int16) {
        if(entityName == "List") {
            switch attributeName {
            case "listID" : lists[index].listID = element; break
            case "count" : lists[index].count = element;
            default: break
            }
        }
            
        else if(entityName == "OfflineRecipe") {
            switch attributeName {
            case "offlineID" : recipes[index].offlineID = element; break
            case "yield" : recipes[index].yield = element; break
            default: break
            }
        }
            
        else if(entityName == "RecipeListTable") {
            switch attributeName {
            case "listID" : tables[index].listID = element; break
            case "recipeID" : tables[index].recipeID = element; break
            default: break
            }
        }
        
        else if(entityName == "RecipeIndexManager") {
            switch attributeName {
            case "recipeID" : indices[index].recipeID = element; break
            default : break
            }
        }
        
        updateObjects()
        save()
    }
    
    func update(index: Int, entityName: String, attributeName: String, element: String) {
        if(entityName == "List") {
            switch attributeName {
            case "name" : lists[index].name = element; break
            default: break
            }
        }
            
        else if(entityName == "OfflineRecipe") {
            switch attributeName {
            case "name" : recipes[index].name = element; break
            case "ingredients" : recipes[index].ingredients = element; break
            case "instructions" : recipes[index].instructions = element; break
            case "author" : recipes[index].author = element; break
            case "summary" : recipes[index].summary = element; break
            default: break
            }
        }
        
        else if(entityName == "RecipeIndexManager") {
            switch attributeName {
            case "source" : indices[index].source = element; break
            default: break
            }
        }
        
        else if(entityName == "User") {
            if(attributeName == "name") {
                author[0].name = element
            }
        }
        
        updateObjects()
        save()
    }
    
    func update(index: Int, entityName: String, attributeName: String, element: Bool) {
        if(entityName == "RecipeIndexManager") {
            switch attributeName {
            case "isOffline" : indices[index].isOffline = element; break
            default: break
            }
        }
        
        updateObjects()
        save()
    }
    
    func feedingDummyData() {
        // RECIPES
        recipeManager.set(offlineID: 0, name: "Recipe 1", ingredients: "", instructions: "", yield: 4, author: "Eva Jobst", summary: "")
        
        recipeManager.set(offlineID: 0, name: "Recipe 1", ingredients: "", instructions: "", yield: 4, author: "Eva Jobst", summary: "")
        
        recipeManager.set(offlineID: 0, name: "Recipe 1", ingredients: "", instructions: "", yield: 4, author: "Eva Jobst", summary: "")
        
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
        
        // INDICES
        // TABLES
        for i in 0..<indices.count {
            indexManager.delete(entity: indices[i])
        }
        
        // SAVING
        recipeManager.save()
        recipeManager.update()
        listManager.save()
        listManager.update()
        tableManager.save()
        tableManager.update()
        indexManager.save()
        indexManager.update()
        
        recipes = recipeManager.fetchedEntity as! [OfflineRecipe]
        lists = listManager.fetchedEntity as! [List]
        tables = tableManager.fetchedEntity as! [RecipeListTable]
        indices = indexManager.fetchedEntity as! [RecipeIndexManager]
    }
    
    func getRecipeID(source : Int16) -> Int16 {
        var id : Int16 = Int16(INT16_MIN)
        
        for index in indices {
            if(index.source == source.description) {
                id = index.recipeID
            }
        }
        return id
    }
    
    func getTableEntry(listID: Int16, recipeID: Int16) -> RecipeListTable {
        for table in tables {
            if(table.listID == listID && table.recipeID == recipeID) {
                return table
            }
        }
        
        return RecipeListTable()
    }
    
    func getIndexEntry(source: Int16) -> RecipeIndexManager {
        for index in indices {
            if(index.source == source.description) {
                return index
            }
        }
        
        return RecipeIndexManager()
    }
    
    func getTableEntries(recipeID: Int16) -> [RecipeListTable] {
        var retTable : [RecipeListTable] = []
        
        for table in tables {
            if(table.recipeID == recipeID) {
                retTable.append(table)
            }
        }
        
        return retTable
    }
    
    func getRecipeID(source : String) -> Int16 {
        var id : Int16 = Int16(INT16_MIN)
        
        for index in indices {
            if(index.source == source) {
                id = index.recipeID
            }
        }
        
        return id
    }
    
    func getconvertedRecipes() -> [RecipeObject] {
        var objects : [RecipeObject] = []
        
        for recipe in recipes {
            objects.append(RecipeObject(data: recipe))
        }
        
        return objects
    }
    
    func getRecipe(offlineID: Int16) -> OfflineRecipe {
        for recipe in recipes {
            if(offlineID == recipe.offlineID) {
                return recipe
            }
        }
        
        return OfflineRecipe()
    }
    
    func isInList(listID: Int16, recipeID: Int16) -> Bool {
        for table in tables {
            if(table.listID == listID && table.recipeID == recipeID) {
                return true
            }
        }
        
        return false
    }
    
    func hasIndex(recipeID: Int16) -> Bool {
        for index in indices {
            if(index.recipeID == recipeID) {
                return true
            }
        }
        
        return false
    }
}
