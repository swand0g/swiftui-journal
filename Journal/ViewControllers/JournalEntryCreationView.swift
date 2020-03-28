//
//  JournalEntryCreationView.swift
//  Journal
//
//  Created by Alexander Swanson on 2/13/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import SwiftUI
import CoreData
        
struct JournalEntryCreationView: View {
        
    var viewContext: NSManagedObjectContext
    
    @Binding
    var showThis: Bool
    
    var text: String =
    """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    """
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                TextView(text: .constant(text))
                .padding()
            }
            .padding(.horizontal, 15)
            .navigationBarTitle("What's new?")
            .navigationBarItems(
                leading:
                Button("Cancel") {
                    self.showThis = false
                    print("Closing without saving.")
                },
                trailing:
                Button("Save") {
                    withAnimation { JournalEntry.create(in: self.viewContext, with: self.text) }
                    self.showThis = false
                    print("Closing and saving.")
                }
            )
        }
        .background(with: .green)
    }
}

extension View {
  func background(with color: Color) -> some View {
    background(GeometryReader { geometry in
      Rectangle().path(in: geometry.frame(in: .local)).foregroundColor(color)
    })
  }
}

struct JournalEntryCreationView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return JournalEntryCreationView(viewContext: context, showThis: .constant(true))
    }
}
