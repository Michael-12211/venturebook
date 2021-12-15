//
//  Note.swift
//  VentureBookAppClip
//
//  Created by Michael Kempe on 2021-12-15.
//

import Foundation

//Since the firebase import prevents the actual note class from being use, even with active compilation conditions, this copy had to be made

struct Note : Codable, Identifiable, Hashable {
    var id = UUID()
    var title: String
    var desc: String
    var location: String
    var posted: Date
    var uploaded: Int
    var trip: String
    var picture: Data
    
    //use this initializer when making a new note
    init (title: String, desc: String, trip: String, picture: Data, location: String)
    {
        self.title = title
        self.desc = desc
        self.trip = trip
        self.location = location
        self.posted = Date()
        self.uploaded = 0;
        self.picture = picture
    }
}
