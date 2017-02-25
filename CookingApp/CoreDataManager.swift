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
    //var count : Int
    
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
        
        //if(fetchedEntity != nil) {count = (fetchedEntity?.count)!}
        //else {count = 0}
    }
    
    func delete(entity: T) {
        managedContext?.delete(entity as NSManagedObject)
        //count = count - 1
    }
    
    func setList(listID : String, numOfRecipes : Int16, name : String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(listID, forKey: "listID")
        data.setValue(numOfRecipes, forKey: "numOfRecipes")
        data.setValue(name, forKey: "name")
        
        //count = count + 1
    }
    
    func setTable(listID: Int16, recipeID: Int16) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(listID, forKey: "listID")
        data.setValue(recipeID, forKey: "recipeID")
        
        //count = count + 1
    }
    
    func setRecipe(recipeID: Int16, fetchID: String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(recipeID, forKey: "recipeID")
        data.setValue(fetchID, forKey: "fetchID")
        
        //count = count + 1
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
