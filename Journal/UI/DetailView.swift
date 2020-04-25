//
//  DetailView.swift
//  Journal
//
//  Created by Alexander Swanson on 2/13/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct DetailView: View {
    
    @ObservedObject var journalEntry : JournalEntry
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(journalEntry.timestamp!, formatter: dateFormatter)")
            }
            .navigationBarTitle(Text(journalEntry.title!), displayMode: .inline)
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        return DetailView(journalEntry: (UIApplication.shared.delegate as! AppDelegate).db_journal_entry)
    }
}
