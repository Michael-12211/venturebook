//
//  Post.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-29.
//

import Foundation
import FirebaseFirestoreSwift

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
    
    // parse JSON into swift obj
    init?(dictionary: [String: Any]) {
        guard let title = dictionary["title"] as? String else {
            return nil
        }
        guard let desc = dictionary["desc"] as? String else {
            return nil
        }
        guard let location = dictionary["location"] as? String else {
            return nil
        }
        guard let posted = dictionary["posted"] as? Date else {
            return nil
        }
        guard let picture = dictionary["picture"] as? Data else {
            return nil
        }
        
        self.init(title: title, desc: desc, location: location, posted: posted, picture: picture)
    }
    
    // test initializer for firebase integration (to be deleted)
    init(title: String, desc: String){
        self.title = title
        self.desc = desc
        self.location = "here"
        self.posted = Date.init()
        self.picture = Data.init()
        self.trip = "N/A"
        self.uploaded = 2
    }
}

