//
//  ContentView.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
//
//  Created by Michael Kempe on 2021-10-29.
//

import SwiftUI
import AVKit
struct ContentView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor.init(Color.headerColor)]
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack(spacing: 20){
                    Button (action:{
                        print ("Navigating to the add Note screen")
                    }) {
                        NavigationLink("New Note", destination: AddNote())
                    }
                    .navigationBarTitle("Home").navigationBarItems(trailing: Image(systemName: "house.fill").foregroundColor(Color(.black))
)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                    Button (action:{
                        print ("Navigating to the my notes screen")
                    }) {
                        NavigationLink("My Notes", destination: MyNotes(trip : ""))
                    }.padding()
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                    Button (action:{
                        print ("Going to trip view")
                    }) {
                        NavigationLink("My Trips", destination: TripView())
                    }.padding()
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                    Button (action:{
                        print ("Navigating to the maps screen")
                    }) {
                        NavigationLink("My Map", destination: MapView())
                    }.padding()
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                    Button (action:{
                        print ("Navigating to online map screen")
                    }) {
                        NavigationLink("Public Map", destination: FirebaseMap())
                    }.padding()
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                }
            }.background(Color(red: 1.0, green: 0.9254901960784314, blue: 0.8196078431372549))
            
                .onAppear(){
                    self.locationHelper.checkPermission()
                }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
