//
//  MasterView.swift
//  Journal
//
//  Created by Alexander Swanson on 2/13/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import SwiftUI

public let shortDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    return dateFormatter
}()

public let mediumDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct MasterView: View {
    
    @FetchRequest(
        entity: JournalEntry.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntry.timestamp, ascending: false)]
    )
    var journalEntries: FetchedResults<JournalEntry>
    
    @State var date = Date()

    @Environment(\.managedObjectContext)
    var viewContext
    
    @State
    var showJournalEntryCreationView: Bool = false
    
    @State
    var alertIsPresented: Bool = false
    
    @State
    var indexSet: IndexSet = IndexSet()

    var body: some View {
        NavigationView {
            List {
                ForEach(journalEntries, id: \.self) { entry in
                    JournalEntryListRow(journalEntry: entry)
                    
                }.onDelete { indices in
                    self.alertIsPresented = true
                    self.indexSet = indices
                }.alert(isPresented: $alertIsPresented) {
                    Alert(
                        title: Text("Are you sure you want to delete that?"),
                        message: Text("This can't be undone"),
                        primaryButton: .destructive(Text("Delete")) {
                            self.journalEntries.delete(at: self.indexSet, from: self.viewContext)
                            print("Deleting at: \(self.indexSet)")
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .navigationBarTitle(Text("Journal"))
            .navigationBarItems(
                // Edit Button
                leading:
                    EditButton(),
                // Button to add a new journal entry
                trailing:
                    Button(action: {withAnimation {self.showJournalEntryCreationView = true}}) {
                        Image(systemName: "pencil.circle")
                    }
                    .sheet(isPresented: $showJournalEntryCreationView, content: {
                        JournalEntryCreationView(viewContext: self.viewContext, showThis: self.$showJournalEntryCreationView)
                    })
            )
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
    
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return MasterView()
            .environment(\.managedObjectContext, context)
            .previewDisplayName("iPhone 11")
    }
}
