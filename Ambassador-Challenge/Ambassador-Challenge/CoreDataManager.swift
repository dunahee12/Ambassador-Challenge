//
//  CoreDataManager.swift
//  Ambassador-Challenge
//
//  Created by Jacob Dunahee on 6/17/15.
//  Copyright (c) 2015 Jacob Dunahee. All rights reserved.
//

import UIKit

class CoreDataManager: NSObject {
    // Saves new link coredata entity  with a dictionary of keys and values
    class func saveLinkToCoreDataWithValues(values: NSDictionary) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDelegate.managedObjectContext
        var entityDesc = NSEntityDescription.entityForName("Link", inManagedObjectContext: context!)
        var managedObject = NSManagedObject(entity: entityDesc!, insertIntoManagedObjectContext: context)
        
        var dictValues = values.allKeys
        
        // Adds new valus to managedObject from dictionary
        for var i = 0; i < dictValues.count; i++ {
            var key = dictValues[i] as! String
            var objectValue: AnyObject? = values.objectForKey(key)
            managedObject.setValue(objectValue, forKey: key)
        }
        
        appDelegate.saveContext()
    }
    
    // Gets array of all the links from coredata
    class func getLinksFromCoreData() -> NSArray {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDelegate.managedObjectContext
        var request = NSFetchRequest(entityName: "Link")
        var error : NSError? = NSError()
        
        var linkArray = context?.executeFetchRequest(request, error: &error)
        return linkArray!
    }

    // Deletes a link object from coredata
    class func deleteLink(object: NSManagedObject) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDelegate.managedObjectContext
        context?.deleteObject(object)
        var error: NSError? = NSError()
        context?.save(&error)
    }

    // Updates the link openedCount
    class func addNewLinkCount(link: NSManagedObject, count: Int) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDelegate.managedObjectContext
        link.setValue(count, forKeyPath: "openCount")
        var error: NSError? = NSError()
        context?.save(&error)
    }
    
    // Edits link name by grabbing saved managed object
    class func editLinkName(link: NSManagedObject, newName: String) {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDelegate.managedObjectContext
        link.setValue(newName, forKeyPath: "name")
        var error: NSError? = NSError()
        context?.save(&error)
    }
}
