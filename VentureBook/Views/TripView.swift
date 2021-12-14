//
//  TripView.swift
//  VentureBook
//
//  Created by Anh Phan on 2021-12-13.
//

import SwiftUI

struct TripView: View {
    @EnvironmentObject var tripCDBHelper : TripCDBHelper
    @State private var selection : Int? = nil
    @State private var selectedTrip: String = ""

    var body: some View {
        ZStack(alignment: .bottom){
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
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
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView()
    }
}
