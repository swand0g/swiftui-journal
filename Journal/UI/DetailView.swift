//
//  DetailView.swift
//  Journal
//
//  Created by Alexander Swanson on 2/13/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var journalEntry : JournalEntry
    
    var body: some View {

        VStack {
            if journalEntry.timestamp != nil {
                Text("\(journalEntry.timestamp!, formatter: dateFormatter)")
            } else {
                EmptyView()
            }
        }.navigationBarTitle("\(journalEntry.title ?? "")")
    
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        return DetailView(journalEntry: (UIApplication.shared.delegate as! AppDelegate).db_journal_entry)
    }
}
