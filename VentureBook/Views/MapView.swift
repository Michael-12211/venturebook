//
//  MapsView.swift
//  VentureBook
//
//  Created by Kevin Tran on 2021-12-02.
//

import SwiftUI
import MapKit

struct MapsView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationHelper.currentLocation!.coordinate.latitude, longitude: locationHelper.currentLocation!.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                    .frame(width: 400, height: 300)
    }
}

struct MapsView_Previews: PreviewProvider {
    static var previews: some View {
        MapsView()
    }
}
