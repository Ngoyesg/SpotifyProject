//
//  CoreDataManager.swift
//  gndjf
//
//  Created by Natalia Goyes on 19/08/22.
//

import CoreData

class CoreDataManager {
    
    private let container: NSPersistentContainer

    init(){
        container = NSPersistentContainer(name: Constants.coreModel)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading store \(description) - \(error)")
                return
            }
        }
    }
    
    func getViewContext() -> NSManagedObjectContext {
        return container.viewContext
    }
    
}
