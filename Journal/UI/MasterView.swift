//
//  MasterView.swift
//  Journal
//
//  Created by Alexander Swanson on 2/13/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import SwiftUI

public let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct MasterView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntry.timestamp, ascending: true)],
        animation: .default)
    var journalEntries: FetchedResults<JournalEntry>

    @Environment(\.managedObjectContext)
    var viewContext
    
    @State
    var showJournalEntryCreationView: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(journalEntries, id: \.self) { entry in
                    NavigationLink(
                        destination: DetailView(journalEntry: entry)
                    ) {
                        Text("\(entry.timestamp!, formatter: dateFormatter)")
                    }
                }.onDelete { indices in
                    self.journalEntries.delete(at: indices, from: self.viewContext)
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
