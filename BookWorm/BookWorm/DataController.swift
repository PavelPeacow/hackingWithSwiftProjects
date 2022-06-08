//
//  DataController.swift
//  BookWorm
//
//  Created by Павел Кай on 08.06.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load \(error.localizedDescription)")
            }
        }
    }
}
