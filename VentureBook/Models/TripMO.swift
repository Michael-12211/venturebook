//
//  TripMO.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-31.
//

import Foundation
import CoreData

@objc(TripMO)
final class TripMO: NSManagedObject{
    @NSManaged var id: UUID?
    @NSManaged var title: String
    @NSManaged var created: Date
}

extension TripMO{
    func convertToTrip() -> Trip{
        return Trip(id: id ?? UUID(), title: title, created: created)
    }
}
