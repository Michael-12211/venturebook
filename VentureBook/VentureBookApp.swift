//
//  VentureBookApp.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-29.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct VentureBookApp: App {
    
    let locationHelper = LocationHelper()
    
    let notePersistenceController = NotePersistenceController.shared
    let tripPersistenceController = TripPersistenceController.shared
    let noteCDBHelper = NoteCDBHelper(context: NotePersistenceController.shared.container.viewContext)
    let tripCDBHelper = TripCDBHelper(context: TripPersistenceController.shared.container.viewContext)
    
    let fireDbHelper : FireDBHelper
    
    init() {
        FirebaseApp.configure()
        fireDbHelper = FireDBHelper(database: Firestore.firestore())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(noteCDBHelper).environmentObject(tripCDBHelper)
                .environmentObject(locationHelper)
                .environmentObject(fireDbHelper)
        }
    }
}
