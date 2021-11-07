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
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = "1"
    @State private var description = "1"
    @State private var trip = "none"
    @State private var picture: Data? = nil
    
    @State private var trips = [String]()
    
    var body: some View {
        VStack {
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
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}
