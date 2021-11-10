//
//  AddNote.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-11-06.
//

import SwiftUI

struct AddNote: View {
    
    @EnvironmentObject var noteCDBHelper : NoteCDBHelper
    @EnvironmentObject var tripCDBHelper : TripCDBHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var description = ""
    @State private var trip = "none"
    @State private var picture: Data? = nil
    
    @State private var trips = [String]()
    
    var body: some View {
        VStack {
            HStack
            {
                Text("Title: ")
                TextField("title", text: self.$title)
            }
            HStack
            {
                Text("Trip:")
                    .padding(.leading, 50.0)
                Picker("Please choose trip", selection: $trip){
                ForEach(trips, id: \.self) {
                    Text($0)
                }
                    
            }
            .frame(height: 250.0)
                .pickerStyle(WheelPickerStyle())                    }
            .navigationBarTitle("Place Reservation", displayMode: .inline)
            
            Text("Description:")
            ZStack //allows enterring a multi-line description
            {
                TextEditor(text: $description)
                Text(description).opacity(0).padding(.all, 8)
            }
            
            Button(action:{
                addNote()
            }){
                Text("Add note")
            }
        }
        .onAppear(){
            self.tripCDBHelper.getAllTrips()
            if (tripCDBHelper.mTrips.count > 0)
            {
                for nTrip in tripCDBHelper.mTrips
                {
                    trips.append(nTrip.title)
                }
                trip = tripCDBHelper.mTrips[0].title
            }
            else
            {
                trips.append("none")
            }
        }
    }
    
    private func addNote()
    {
        //TODO
        //once the picture can be added, save to coreDB
        self.presentationMode.wrappedValue.dismiss()
        
        // Firebase integration testing
        let newNote = Note(title:title, desc:description)
        fireDBHelper.insertNote(newNote: newNote)
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}
