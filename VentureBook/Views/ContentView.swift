//
//  ContentView.swift
//  VentureBook
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
                    NavigationLink("Make a note", destination: AddNote())
                }
                .navigationBarTitle("Home")
                .padding()
                .foregroundColor(Color.white)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                Button (action:{
                    print ("Navigating to the my notes screen")
                }) {
                    NavigationLink("View Notes", destination: MyNotes())
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
