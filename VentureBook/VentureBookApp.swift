//
//  VentureBookApp.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-29.
//

import SwiftUI

@main
struct VentureBookApp: App {
    
    let persistenceController = PersistenceController.shared
    let noteCDBHelper = NoteCDBHelper(context: PersistenceController.shared.container.viewContext)
    let tripCDBHelper = TripCDBHelper(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(noteCDBHelper).environmentObject(tripCDBHelper)
        }
    }
}
