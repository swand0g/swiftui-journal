//
//  Location.swift
//  Journal
//
//  Created by Alexander Swanson on 2/13/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import SwiftUI
import CoreData

extension Location {
    static func create(in managedObjectContext: NSManagedObjectContext){
        let newLocation = self.init(context: managedObjectContext)
        
        // Implement creation
        newLocation.latitude = 0
        newLocation.longitude = 0
        
        do {
            try  managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

extension Collection where Element == Location, Index == Int {
    func delete(at indices: IndexSet, from managedObjectContext: NSManagedObjectContext) {
        indices.forEach { managedObjectContext.delete(self[$0]) }
 
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
