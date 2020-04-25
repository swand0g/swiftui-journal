//
//  Notifications.swift
//  Journal
//
//  Created by Alexander Swanson on 4/25/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static var didSelectDeletedItem: Notification.Name {
        return Notification.Name("Deleted CoreData item")
    }
    
}
