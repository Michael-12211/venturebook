//
//  MapsView.swift
//  VentureBook
//
//  Created by Kevin Tran on 2021-12-02.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var noteCDBHelper : NoteCDBHelper
    @EnvironmentObject var locationHelper : LocationHelper
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.46909205277883, longitude: -79.69961738210894), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true,  userTrackingMode: .constant(.follow), annotationItems: self.noteCDBHelper.mNotes.map{
            i in
            i.convertToNote()
        }){
            return self.locationHelper.doGeocoding(address: $0.location, completionHandler: { (address, error) in
                
                if (error == nil && address != nil){
                    //sucessfully obtained coordinates
                    let coordinate = address!
                    MapPin(coordinate: coordinate, tint: Color.blue)
                    print(#function, "Address obtained : \(address!)")
                    
                }
            })
        }
                    .frame(width: 400, height: 300)
                    .onAppear(){
                        self.noteCDBHelper.getAllNotes()
                        self.noteCDBHelper.mNotes.forEach{
                            i in
                            
                        }
                    }
    }
        
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
