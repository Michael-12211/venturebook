//
//  TripCDBHelper.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
//
//  Created by Michael Kempe on 2021-10-31.
//

import Foundation
import CoreData
import UIKit

class TripCDBHelper: ObservableObject{
    
    @Published var mTrips = [TripMO]()
    
    private static var shared : TripCDBHelper?
    
    static func getInstance() -> TripCDBHelper {
        if shared != nil{
            //instance of CoreDBHelper class already exists, so return the same
            return shared!
        }else{
            //there is no existing instance of CoreDBHelper class, so create new and return
            shared = TripCDBHelper(context: TripPersistenceController.preview.container.viewContext)
            return shared!
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "TripMO"
    
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertTrip(trip: Trip){
        do{
            
            let insertedTrip = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! TripMO
             
            insertedTrip.id = trip.id
            insertedTrip.title = trip.title
            insertedTrip.created = trip.created
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Trip saved")
            }
            
        }catch let error as NSError{
            print(#function, "Trip not saved: \(error)")
        }
    }
    
    func getAllTrips(){
        let fetchRequest = NSFetchRequest<TripMO>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "created", ascending: false)]
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "\(result.count) fetched")
            self.mTrips.removeAll()
            self.mTrips.insert(contentsOf: result, at: 0)
            
        }catch let error as NSError{
            print(#function, "Couldn't fetch data: \(error)")
        }
    }
    
    private func searchTrip(tripID : UUID) -> TripMO?{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", tripID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            if result.count > 0{
                return result.first as? TripMO
            }
        }catch let error as NSError{
            print(#function, "Unable to search for data \(error)")
        }
        
        return nil
        
    }
    
    func deleteTrip(tripID : UUID){
        let searchResult = self.searchTrip(tripID: tripID)
        
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
            print(#function, "Trip not found")
        }
    }
    
    func updateTrip(updatedTrip: TripMO){
        let searchResult = self.searchTrip(tripID: updatedTrip.id! as UUID)
        
        if (searchResult != nil){
            //matching object found
            do{
                let tripToUpdate = searchResult!
                
                tripToUpdate.title = updatedTrip.title
                tripToUpdate.created = updatedTrip.created
                
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Updated")
                
            }catch let error as NSError{
                print(#function, "Couldn't update: \(error)")
            }
        }else{
            print(#function, "Trip not found")
        }
    }

}
