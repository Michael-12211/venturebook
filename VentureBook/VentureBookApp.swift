//
//  VentureBookApp.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
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
        MusicPlayer.shared.startBackgroundMusic(song: "waves")

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
