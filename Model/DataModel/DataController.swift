//
//  DataController.swift
//  Gbese Tracker
//
//  Created by Osifeso Adeyemi on 22/02/2021.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil){
        persistentContainer.loadPersistentStores { (storeDetails, error) in
            guard error == nil else { return }
            print("loaded successfully")
            completion?()
        }
    }
}

