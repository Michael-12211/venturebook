//
//  FirebaseMap.swift
//  VentureBook
//
//  Created by Kevin Tran on 2021-12-13.
//

import SwiftUI
import MapKit

struct FirebaseMap: View {
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
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            Map(coordinateRegion: $region, showsUserLocation: true,  userTrackingMode: .constant(.follow),
                annotationItems: pings){item in MapMarker(coordinate: item.coordinate, tint: Color.blue)}
                .frame(width: 400, height: 300)
                .onAppear()
        }.navigationBarTitle("Firebase Map", displayMode: .inline).navigationBarItems(trailing: Image(systemName: "map.circle.fill"))
    }
}

struct FirebaseMap_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseMap()
    }
}
