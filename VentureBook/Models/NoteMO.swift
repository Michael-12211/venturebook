//
//  NoteMO.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
//
//  Created by Michael Kempe on 2021-10-29.
//

import Foundation
import CoreData

@objc(NoteMO)
final class NoteMO: NSManagedObject, Identifiable{
    @NSManaged var id: UUID?
    @NSManaged var title: String
    @NSManaged var desc: String
    @NSManaged var uploaded: Int
    @NSManaged var posted: Date
    @NSManaged var location: String
    @NSManaged var trip: String
    @NSManaged var picture: Data
}

extension NoteMO{
    func convertToNote() -> Note{
        Note(id: id ?? UUID(), title: title, desc: desc, trip: trip, location: location, posted: posted, uploaded: uploaded, picture: picture)
    }
}
