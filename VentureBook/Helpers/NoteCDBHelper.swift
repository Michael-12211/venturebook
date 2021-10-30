//
//  NoteCDBHelper.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-30.
//

import Foundation
import CoreData
import UIKit

class NoteCDBHelper: ObservableObject{
    
    @Published var mNotes = [NoteMO]()
    
    private static var shared : NoteCDBHelper?
    
    static func getInstance() -> NoteCDBHelper {
        if shared != nil{
            //instance of CoreDBHelper class already exists, so return the same
            return shared!
        }else{
            //there is no existing instance of CoreDBHelper class, so create new and return
            shared = NoteCDBHelper(context: PersistenceController.preview.container.viewContext)
            return shared!
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "NoteMO"
    
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertNote(note: Note){
        do{
            
            let insertedNote = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! NoteMO
             
            insertedNote.id = UUID()
            insertedNote.title = note.title
            insertedNote.desc = note.desc
            insertedNote.location = note.location
            insertedNote.posted = note.posted
            insertedNote.picture = note.picture
            insertedNote.uploaded = note.uploaded
            insertedNote.trip = note.trip
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Note saved")
            }
            
        }catch let error as NSError{
            print(#function, "Note not saved: \(error)")
        }
    }
    
    func getAllNotes(){
        let fetchRequest = NSFetchRequest<NoteMO>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "posted", ascending: false)]
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "\(result.count) fetched")
            self.mNotes.removeAll()
            self.mNotes.insert(contentsOf: result, at: 0)
            
        }catch let error as NSError{
            print(#function, "Couldn't fetch data: \(error)")
        }
    }
    
    private func searchNote(noteID : UUID) -> NoteMO?{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", noteID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            if result.count > 0{
                return result.first as? NoteMO
            }
        }catch let error as NSError{
            print(#function, "Unable to search for data \(error)")
        }
        
        return nil
        
    }
    
    func deleteNote(noteID : UUID){
        let searchResult = self.searchNote(noteID: noteID)
        
        if (searchResult != nil){
            //matching object found
            do{
                self.moc.delete(searchResult!)
                
                
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Deleted")
            }catch let error as NSError{
                print(#function, "Couldn't delete: \(error)")
            }
        }else{
            print(#function, "Note not found")
        }
    }
    
    func updateNote(updatedNote: NoteMO){
        let searchResult = self.searchNote(noteID: updatedNote.id! as UUID)
        
        if (searchResult != nil){
            //matching object found
            do{
                let noteToUpdate = searchResult!
                
                noteToUpdate.title = updatedNote.title
                noteToUpdate.desc = updatedNote.desc
                noteToUpdate.location = updatedNote.location
                noteToUpdate.posted = updatedNote.posted
                noteToUpdate.picture = updatedNote.picture
                noteToUpdate.uploaded = updatedNote.uploaded
                noteToUpdate.trip = updatedNote.trip
                
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Updated")
                
            }catch let error as NSError{
                print(#function, "Couldn't update: \(error)")
            }
        }else{
            print(#function, "Note not found")
        }
    }

}
