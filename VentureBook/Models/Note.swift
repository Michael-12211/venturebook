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
    var desc: String
    var location: String
    var posted: Date
    var uploaded: Int
    var trip: String
    var picture: Data
    
    //use this initializer when making a new note
    init (title: String, desc: String, trip: String, picture: Data)
    {
        self.title = title
        self.desc = desc
        self.trip = trip
        self.location = "TODO"
        self.posted = Date()
        self.uploaded = 0;
        self.picture = picture
    }
    
    //use this initializer when taking a note from the core data
    init (id: UUID, title: String, desc: String, trip: String, location: String, posted: Date, uploaded: Int, picture: Data)
    {
        self.id = id
        self.title = title
        self.desc = desc
        self.location = location
        self.posted = posted
        self.uploaded = uploaded
        self.trip = trip
        self.picture = picture
    }
    
    //use this initializer when taking a note from the online database
    init (title: String, desc: String, location: String, posted: Date, picture: Data)
    {
        self.title = title
        self.desc = desc
        self.location = location
        self.posted = posted
        self.picture = picture
        self.uploaded = 2; //as this was retreived from the database
        self.trip = "N/A" //not stored in database as it is irrelevent
    }
    
}

