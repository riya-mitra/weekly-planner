//
//  CoreDataModule.swift
//  Stack Report
//
//  Created by Cyril Garcia on 5/10/17.
//  Copyright © 2017 ByCyril. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataModule: Module {
    
    private var entity: String!
    
    public init(entityName: String, xcDataModelID: String) {
        super.init(xcDataModelID: xcDataModelID)
        entity = entityName
    }
    
    public func push<Values>(values: [Values], keys: [String]) {
        
        let managedContext = managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "\(self.entity!)", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        for i in 0..<keys.count {
            item.setValue(values[i], forKey: keys[i])
        }
        
        try? managedContext.save()
    }
    
    public func retrieveData() -> [NSManagedObject]{

        let managedContext = managedObjectContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(self.entity!)")
        
        let results = try? managedContext.fetch(fetchrequest) as! [NSManagedObject]
        return results!

    }
    
    public func retrieveAndSort(byKey: String, ascending: Bool) -> [NSManagedObject] {
        
        let managedContext = managedObjectContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(self.entity!)")
        
        let sectionSortDescriptor = NSSortDescriptor(key: byKey, ascending: ascending)
        let sortDescriptor = [sectionSortDescriptor]
        fetchrequest.sortDescriptors = sortDescriptor
        
        let results = try? managedContext.fetch(fetchrequest) as! [NSManagedObject]
        return results!
       
    }
    
    public func removeAll() {
        let managedContext = managedObjectContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: self.entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There was an error")
        }
    }
    
    public func remove(object: [NSManagedObject], index: Int) {

        let managedContext = managedObjectContext
        managedContext.delete(object[index])
        try? managedContext.save()

    }
    
    public func filterBy<T>(value: T, withKey: String) -> [NSManagedObject] {
        
        let managedContext = managedObjectContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(self.entity!)")

        var predicate: NSPredicate!
        
        if let intValue = value as? Int {
            predicate = NSPredicate(format: "\(withKey) = %i", intValue)
        }
        
        if let double = value as? Double {
            predicate = NSPredicate(format: "\(withKey) = %f", double)
        }
        
        if let strValue = value as? String {
            predicate = NSPredicate(format: "\(withKey) = %@", strValue)
        }
        
        fetchrequest.predicate = predicate
        let results = try? managedContext.fetch(fetchrequest) as! [NSManagedObject]
        return results!
    }
}






