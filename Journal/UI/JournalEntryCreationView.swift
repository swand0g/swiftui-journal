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
    
    @State var input: String = ""
    
    @State var title: String = ""
    
    @Binding
    var showThis: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Write it down here...", text: $input)
                Divider()
                TextField("Add a title?", text: $title)
                Spacer()
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
                    withAnimation { JournalEntry.create(in: self.viewContext, withTitle: self.title, withContent: self.input) }
                    self.showThis = false
                    print("Closing and saving.")
                }
            )
        }
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
