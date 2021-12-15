//
//  TripView.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
//
//  Created by Anh Phan on 2021-12-13.
//

import SwiftUI

struct TripView: View {
    @EnvironmentObject var tripCDBHelper : TripCDBHelper
    @EnvironmentObject var locationHelper : LocationHelper
    @State private var selection : Int? = nil
    @State private var selectedTrip: String = ""
    
    @State private var addTripSheet = false
    @State private var newTripTitle: String = ""

    var body: some View {
        //VStack {
        ZStack(alignment: .bottom){
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    NavigationLink(destination: MyNotes(trip: selectedTrip), tag: 1, selection: $selection){}
                    List{
                        ForEach(self.tripCDBHelper.mTrips.map{$0.convertToTrip()}, id: \.self) { x in
                            Text(x.title).tag(x.title)
                            .onTapGesture {
                                self.selection = 1
                                self.selectedTrip = x.title
                            }
                        }.onDelete{ indexSet in
                            for index in indexSet {
                                self.tripCDBHelper.deleteTrip(tripID: self.tripCDBHelper.mTrips[index].id!)
                                self.tripCDBHelper.mTrips.remove(at: index)
                            }
                        }
                    }.onAppear{
                        tripCDBHelper.getAllTrips()
                    }
                }
                Button("Trip:  Add Trip", action: {
                    addTripSheet = true
                })
                .sheet(isPresented: $addTripSheet, content: {
                    VStack
                    {
                        Form{
                            //VStack(alignment: .center)
                            //{
                                Text("Name your new trip!")
                            //}
                            Section{
                                TextField("New Trip", text: $newTripTitle)
                            }
                            HStack {
                                Button("Add", action: {
                                    let newTrip = Trip(title: newTripTitle)
                                    self.tripCDBHelper.insertTrip(trip: newTrip)
                                    tripCDBHelper.getAllTrips()
                                    addTripSheet = false
                                })
                            }
                        }
                        Button("Back", action: {
                            addTripSheet = false
                        })
                        Spacer()
                    }
                    
                })
                .foregroundColor(Color.headerColor)
            } //VStack
        }
        .onAppear() {
            locationHelper.stopUpdatingLocation()
        }
        //} //VStack
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView()
    }
}
