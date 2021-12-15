//
//  Trip.swift
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

struct Trip : Identifiable, Hashable {
    var id = UUID()
    var title: String
    var created: Date
    
    init (title: String)
    {
        self.title = title
        self.created = Date()
    }
    
    init (id: UUID, title: String, created: Date)
    {
        self.id = id
        self.title = title
        self.created = created
    }
}
