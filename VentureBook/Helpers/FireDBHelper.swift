//
//  FireDBHelper.swift
//  VentureBook
//
//  Created by Anh Phan on 2021-11-10.
//

import Foundation
import FirebaseFirestore

class FireDBHelper: ObservableObject {
    @Published var noteList = [Note]()
    private let NOTES_COLLECTION_NAME: String = "Notes"
    private let store : Firestore
    
    private static var shared: FireDBHelper?
    
    static func getInstance() -> FireDBHelper {
        if shared == nil {
            shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return shared!
    }
    
    init(database: Firestore) {
        self.store = database
    }
    
    func insertNote(newNote: Note) {
        do{
            try self.store.collection(NOTES_COLLECTION_NAME).addDocument(from: newNote)
        }catch let err as NSError{
            print(err)
        }
    }
}
