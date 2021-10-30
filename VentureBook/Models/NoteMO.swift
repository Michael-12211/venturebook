//
//  NoteMO.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-29.
//

import Foundation
import CoreData

@objc(OrderMO)
final class NoteMO: NSManagedObject{
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
