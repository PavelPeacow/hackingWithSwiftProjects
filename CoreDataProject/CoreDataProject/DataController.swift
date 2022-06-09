//
//  DataController.swift
//  CoreDataProject
//
//  Created by Павел Кай on 09.06.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
