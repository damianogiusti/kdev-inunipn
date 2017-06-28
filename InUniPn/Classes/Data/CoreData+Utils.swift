//
//  NSEntityDescription+Utils.swift
//  CoreDataExample
//
//  Created by Damiano Giusti on 08/06/17.
//  Copyright © 2017 Damiano Giusti. All rights reserved.
//

import UIKit
import CoreData

extension NSEntityDescription {

    static func insertNewObject<T: NSManagedObject>(forEntity type: T.Type, into context: NSManagedObjectContext) -> T {
        let name = type.modelName
        // safely force downcast, because the returned object must be of the specified data type
        return NSEntityDescription.insertNewObject(forEntityName: name, into: context) as! T
    }
}

extension NSManagedObject {

    private static var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    static var modelName: String {
        return String(describing: self)
    }

    static func fetchRequest<T: NSManagedObject>() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: modelName)
    }

    static func createNew() -> Self {
        return NSEntityDescription.insertNewObject(forEntity: self, into: context)
    }

    /// Finds all objects of this type
    static func findAll<T: NSManagedObject>() -> [T] {
        let fr: NSFetchRequest<T> = fetchRequest()
        do {
            return try context.fetch(fr) as [T]
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    /// Finds an object of this type by it's ID
    static func find<T: NSManagedObject>(byId id: Any, named idPropertyName: String) -> T? {
        let fr: NSFetchRequest<T> = fetchRequest()
        fr.predicate = NSPredicate(format: "\(idPropertyName) == %@", argumentArray: [id])
        fr.fetchLimit = 1
        do {
            return try context.fetch(fr).first
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    /// Count all occurrencies of this object type
    static func countAll() -> Int {
        let fr: NSFetchRequest<NSManagedObject> = fetchRequest()
        do {
            return try context.count(for: fr)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    /// Count all occurrencies of this object type matching a predicate
    static func countAll(matchingPredicate predicate: NSPredicate) -> Int {
        let fr: NSFetchRequest<NSManagedObject> = fetchRequest()
        fr.predicate = predicate
        do {
            return try context.count(for: fr)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    /// Inserts this object into the container
    @discardableResult
    func insert(andCommit commit: Bool = false) -> Bool {
        do {
            if let context = self.managedObjectContext {
                context.insert(self)
                if commit {
                    try context.save()
                }
                return true
            }
            return false
        } catch {
            return false
        }
    }

    /// Removes this object from the container
    @discardableResult
    func remove(andCommit commit: Bool = false) -> Bool {
        do {
            if let context = self.managedObjectContext {
                context.delete(self)
                if commit {
                    try context.save()
                }
                return true
            }
            return false
        } catch {
            return false
        }
    }

    /// Commits the changes made into the container
    @discardableResult
    func commitChanges() -> Bool {
        do {
            if let context = self.managedObjectContext {
                try context.save()
                return true
            }
            return false
        } catch {
            return false
        }
    }
}
