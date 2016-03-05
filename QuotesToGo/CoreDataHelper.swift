//
//  CoreDataHelper.swift
//  QuotesToGo
//
//  Created by Jacob K Giberson on 3/5/16.
//  Copyright © 2016 Daniel Autenrieth. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper: NSObject {
    class func managedObjectContext() -> NSManagedObjectContext {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    class func insertManagedObject (className:NSString, managedObjectContext:NSManagedObjectContext) -> AnyObject {
        let managedObject = NSEntityDescription.insertNewObjectForEntityForName(className as String, inManagedObjectContext: managedObjectContext)
        
        return managedObjectContext
    }
    
    class func fetchEntities (className:NSString, managedObjectContext:NSManagedObjectContext, predicate:NSPredicate?, sortDescriptor:NSSortDescriptor?) -> NSArray {
        
        let fetchRequest = NSFetchRequest()
        
        let entityDescription = NSEntityDescription.entityForName(className as String, inManagedObjectContext: managedObjectContext)
       
        fetchRequest.entity = entityDescription
        
        if predicate != nil {
            fetchRequest.predicate = predicate!
        }
        
        if sortDescriptor != nil {
            fetchRequest.sortDescriptors = [sortDescriptor!]
        }
        
        var items = []
        
        do {
            try items = managedObjectContext.executeFetchRequest(fetchRequest)
            
        } catch {
            print(error)
        }
        return items
    }
}
