//
//  CoreDataManager.swift
//  CookingApp
//
//  Created by Eva Jobst on 09.02.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//: Class manages all necessary Core Data manipulations
class CoreDataManager<T : NSManagedObject> {
    let entityName : String
    let managedContext: NSManagedObjectContext?
    var fetchRequest : NSFetchRequest<NSManagedObject>?
    var fetchedEntity : [T]?
    
    init() {
        entityName = ""
        managedContext = nil
        fetchRequest = nil
        fetchedEntity = nil
    }
    
    init(entityName: String) {
        self.entityName = entityName
        
        managedContext = {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil
            }
            return appDelegate.persistentContainer.viewContext
        }()
        
        fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            fetchedEntity = try self.managedContext!.fetch(fetchRequest!) as? [T]
            
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    func delete(entity: T) {
        managedContext?.delete(entity as NSManagedObject)
        
        save()
        update()
    }
    
    // setList
    func set(listID : Int16, count : Int16, name : String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(listID, forKey: "listID")
        data.setValue(count, forKey: "count")
        data.setValue(name, forKey: "name")
        
        save()
        update()
    }
    
    // setTable
    func set(listID: Int16, recipeID: Int16) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(listID, forKey: "listID")
        data.setValue(recipeID, forKey: "recipeID")
        
        save()
        update()
    }
    
    // setRecipe
    func set(offlineID: Int16, name: String, ingredients: String, instructions: String, yield: Int16, author: String, summary: String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(offlineID, forKey: "offlineID")
        data.setValue(name, forKey: "name")
        data.setValue(ingredients, forKey: "ingredients")
        data.setValue(instructions, forKey: "instructions")
        data.setValue(yield, forKey: "yield")
        data.setValue(author, forKey: "author")
        data.setValue(summary, forKey: "summary")
        
        save()
        update()
    }
    
    // setIndex
    func set(recipeID: Int16, isOffline: Bool, source : String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(recipeID, forKey: "recipeID")
        data.setValue(isOffline, forKey: "isOffline")
        data.setValue(source, forKey: "source")
        
        save()
        update()
    }
    
    func set(name: String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(name, forKey: "name")
    }
    
    func save() {
        do {
            try managedContext?.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func update() {
        fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            fetchedEntity = try self.managedContext!.fetch(fetchRequest!) as? [T]
            
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
}
