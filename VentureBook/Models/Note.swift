//
//  Post.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-29.
//

import Foundation

struct Note : Identifiable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var location: String
    var posted: Date
    var uploaded: Int
    var trip: String
    
    //use this initializer when making a new note
    init (title: String, description: String, trip: String)
    {
        self.title = title
        self.description = description
        self.trip = trip
        self.location = "TODO"
        self.posted = Date()
        self.uploaded = 0;
    }
    
    //use this initializer when taking a note from the core data
    init (id: UUID, title: String, description: String, trip: String, location: String, posted: Date, uploaded: Int)
    {
        self.id = id
        self.title = title
        self.description = description
        self.location = location
        self.posted = posted
        self.uploaded = uploaded
        self.trip = trip
    }
    
    //use this initializer when taking a note from the online database
    init (title: String, description: String, location: String, posted: Date)
    {
        self.title = title
        self.description = description
        self.location = location
        self.posted = posted
        self.uploaded = 2; //as this was retreived from the database
        self.trip = "N/A" //not stored in database as it is irrelevent
    }
    
}

