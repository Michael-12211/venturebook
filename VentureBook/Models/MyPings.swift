//
//  MyPings.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-12-14.
//

import Foundation
import MapKit

struct MyPings: Identifiable{
    var coordinate: CLLocationCoordinate2D
    var title: String
    var holding: Note
    let id = UUID()
}
