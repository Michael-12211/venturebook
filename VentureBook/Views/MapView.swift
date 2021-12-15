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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    //variables to store navigation information
    @State private var selection : Int? = nil
    
    @State private var selectedNote : Note? = nil
    
    @State private var loaded = 0
    
    private enum MapDefaults {
        static let latitude = 43.46909205277883
        static let longitude = -79.69961738210894
        static let zoom = 0.5
    }
    
    @State private var pings : [MyPings] = [];
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            NavigationLink(destination: NoteDetails(note: selectedNote), tag: 1, selection: $selection){} //Link to navigate to the details page
            Map(coordinateRegion: $region, showsUserLocation: true,
            annotationItems: pings){item in
                //Custom map annotation
                MapAnnotation(coordinate: item.coordinate)
                {
                    ZStack {
                        Color.white.ignoresSafeArea()
                        VStack {
                            Image(uiImage: UIImage(data: item.holding.picture) ?? UIImage(named: "placeholder")!)
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .leading)
                            Text(item.title).fontWeight(.bold).font(.system(size: 10)).padding(3)
                        }
                    }
                    .onTapGesture {
                        self.selection = 1
                        self.selectedNote = item.holding
                    }
                }
            }
            .frame(width: 400, height: 300)
        }.navigationBarTitle("Map View", displayMode: .inline).navigationBarItems(trailing: Image(systemName: "map.fill"))
        .onAppear(){
            print("Map Appeared")
            self.region.center = CLLocationCoordinate2D(latitude: locationHelper.currentLocation!.coordinate.latitude, longitude: locationHelper.currentLocation!.coordinate.longitude)
            self.noteCDBHelper.getAllNotes()
            loadNotes()
        }

    }
    
    func loadNotes () {
        
        var passed = 0;
        
        self.noteCDBHelper.mNotes.forEach{ i in
            
            if (passed == loaded)
            {
                self.locationHelper.doGeocoding(address: i.location, completionHandler: { (address, error) in
                    
                    if (error == nil && address != nil){
                        //sucessfully obtained coordinates
                        print ("Succeeded for post: " + i.title)
                        let loc = address!
                        pings.append(MyPings(coordinate: CLLocationCoordinate2D(
                            latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude
                        ), title: i.title, holding: i.convertToNote()
                                            )
                        )
                        print(#function, "Address obtained : \(address!)")
                        
                    }else{
                        print(#function, "error: ", error?.localizedDescription as Any)
                    }
                    
                    loaded += 1
                    loadNotes()
                })
            }
            passed += 1
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


