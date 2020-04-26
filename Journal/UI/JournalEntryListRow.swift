//
//  JournalListRow.swift
//  Journal
//
//  Created by Alexander Swanson on 4/25/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import Foundation
import SwiftUI

struct JournalEntryListRow: View {
    
    var journalEntry: JournalEntry
    
    @ViewBuilder
    var body: some View {
        
        NavigationLink(
            destination: DetailView(journalEntry: journalEntry)
        ) {
            HStack {
                
                // Define pic view if the pic exists in the journal entry
                if journalEntry.image != nil {
                    PicView(image: journalEntry.image!)
                } else {
                    EmptyView()
                }

                // Journal entry info
                Text("\(journalEntry.title!)")
                
            }
        }
        
    }
    
}

struct PicView: View {
    
    var image: Data
    
    var body: some View {
        
        if let uiImage = UIImage(data: image) {
            return AnyView(
                Image(uiImage: uiImage)
                    .frame(width: 25.0, height: 25.0)
                .clipShape(Circle())
            )
        }
        return AnyView(EmptyView())
        
    }
    
    
}

struct JournalEntryListRow_Previews: PreviewProvider {
    static var previews: some View {
        let journalEntry = (UIApplication.shared.delegate as! AppDelegate).db_journal_entry
        journalEntry.image = UIImage(named: "sample-pic")?.pngData()
        return JournalEntryListRow(journalEntry: journalEntry)
    }
}
