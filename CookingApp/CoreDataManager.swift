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
    }
    
    func set(listID : Int16, numOfRecipes : Int16, name : String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(listID, forKey: "listID")
        data.setValue(numOfRecipes, forKey: "numOfRecipes")
        data.setValue(name, forKey: "name")

        save()
        update()
    }
    
    func set(listID: Int16, recipeID: Int16) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(listID, forKey: "listID")
        data.setValue(recipeID, forKey: "recipeID")

        save()
        update()
    }
    
    func set(recipeID: Int16, fetchID: String, name: String, details: String, image: String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(recipeID, forKey: "recipeID")
        data.setValue(fetchID, forKey: "fetchID")
        data.setValue(name, forKey: "name")
        data.setValue(details, forKey: "details")
        data.setValue(image, forKey: "image")

        save()
        update()
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
