//
//  DetailView.swift
//  Journal
//
//  Created by Alexander Swanson on 2/13/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import SwiftUI

fileprivate let longDateNoTimeFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    return dateFormatter
}()

struct DetailView: View {
    
    @ObservedObject var journalEntry : JournalEntry
    
    @State var content: String = ""
    
    var titleVal: String {
        if journalEntry.timestamp != nil && journalEntry.title != nil {
            
            if journalEntry.title!.count > 0 {
                return journalEntry.title!
            } else {
                return longDateNoTimeFormatter.string(from: journalEntry.timestamp!)
            }
            
        } else {
            return ""
        }
    }
    
    var body: some View {

        HStack {
            VStack(alignment: .leading) {
                if journalEntry.timestamp != nil && journalEntry.content != nil && journalEntry.title != nil {
                    Text(journalEntry.content!)
                        .multilineTextAlignment(.leading)
                    Spacer()
                } else {
                    EmptyView()
                }
            }.padding(.all).navigationBarTitle(titleVal)
            Spacer()
        }
    
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        return DetailView(journalEntry: (UIApplication.shared.delegate as! AppDelegate).db_journal_entry)
    }
}
