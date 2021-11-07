//
//  ContentView.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-10-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Button (action:{
                    print ("Navigating to the add Trip screen")
                }) {
                    NavigationLink("Make a note", destination: AddNote())
                }
                .navigationBarTitle("Home")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
