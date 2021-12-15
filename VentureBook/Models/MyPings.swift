//
//  MyPings.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
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
