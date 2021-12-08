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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    private enum MapDefaults {
            static let latitude = 43.46909205277883
            static let longitude = -79.69961738210894
            static let zoom = 0.5
        }
    
   @State private var pings = [MyPings(coordinate: CLLocationCoordinate2D(
        latitude: MapDefaults.latitude, longitude: MapDefaults.longitude
    ))]
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true,  userTrackingMode: .constant(.follow),
            annotationItems: pings){item in MapMarker(coordinate: item.coordinate, tint: Color.blue)}
                    .frame(width: 400, height: 300)
                    .onAppear(){
                        self.noteCDBHelper.getAllNotes()
                        self.noteCDBHelper.mNotes.forEach{
                            i in
                            self.locationHelper.doGeocoding(address: i.location, completionHandler: { (address, error) in
                                
                                if (error == nil && address != nil){
                                    //sucessfully obtained coordinates
                                    let loc = address!
                                    pings.append(MyPings(coordinate: CLLocationCoordinate2D(
                                        latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude
                                    ))
                                    )
                                    print(#function, "Address obtained : \(address!)")
                                    
                                }else{
                                    print(#function, "error: ", error?.localizedDescription as Any)
                                }
                            })
                        }
                    }
    }
        
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct MyPings: Identifiable{
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}


