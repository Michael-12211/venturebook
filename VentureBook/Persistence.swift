//
//  Persistence.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-30.
//

import Foundation
import CoreData

struct TripPersistenceController {
    static let shared = TripPersistenceController()
    
    static var preview: TripPersistenceController = {
        let result = TripPersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        return result
    }()
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Trip")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                //TODO: handle error
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
}

struct NotePersistenceController {
    static let shared = NotePersistenceController()
    
    static var preview: NotePersistenceController = {
        let result = NotePersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        return result
    }()
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Note")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                //TODO: handle error
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
}
