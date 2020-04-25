//
//  ContentView.swift
//  Journal
//
//  Created by Alexander Swanson on 2/13/20.
//  Copyright © 2020 ajsv. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext)
    var viewContext   
 
    // Initialize the Master View
    var body: some View {
        MasterView()
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
#endif
