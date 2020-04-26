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
                
                if journalEntry.title != nil && journalEntry.timestamp != nil {
                    
                    if journalEntry.title!.count > 0 {
                        Text("\(journalEntry.title!)")
                        Text("\(journalEntry.timestamp!, formatter: shortDateFormatter)")
                            .font(.caption)
                            .foregroundColor(Color("dateColor"))
                    } else {
                        Text("\(journalEntry.timestamp!, formatter: mediumDateFormatter)")
                            .foregroundColor(Color("dateColor"))
                    }
                    
                }
                
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
