//
//  CoreDataManager.swift
//  04_task01
//
//  Created by Eva Jobst on 29.01.17.
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
    var count : Int
    
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
        
        if(fetchedEntity != nil) {count = (fetchedEntity?.count)!}
        else {count = 0}
    }

    func delete(entity: T) {
        managedContext?.delete(entity as NSManagedObject)
        count = count - 1
    }
    
    func set(valueString : String, forkeyString: String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(valueString, forKey: forkeyString)
        
        count = count + 1
    }
    
    func set(valueInt: Int16, forkeyInt: String, valueString: String, forkeyString: String) {
        let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into:
            managedContext!)
        
        data.setValue(valueInt, forKey: forkeyInt)
        data.setValue(valueString, forKey: forkeyString)
        
        count = count + 1
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
