//
//  LocationHelper.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-11-09.
//

import Foundation
import CoreLocation
import Contacts
import MapKit

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var address : String = "unknown"
    @Published var currentLocation: CLLocation?
    
    private let locationManager = CLLocationManager()
    private var lastSeenLocation: CLLocation?
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        self.checkPermission()
        
        if (CLLocationManager.locationServicesEnabled() && ( self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)){
            self.locationManager.startUpdatingLocation()
        }else{
            self.requestPermission()
        }
        
        self.locationManager.distanceFilter = 5
    }
    
    func requestPermission() {
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func checkPermission(){
        print(#function, "Checking for permission")
        switch self.locationManager.authorizationStatus {
        case .denied:
            self.requestPermission()
        case .notDetermined:
            self.requestPermission()
        case .restricted:
            self.requestPermission()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Authorization Status : \(manager.authorizationStatus.rawValue)")
        self.authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastSeenLocation = locations.first
        print(#function, "last seen location: \(self.lastSeenLocation!)")
        
        if locations.last != nil{
            self.currentLocation = locations.last!
        }else{
            self.currentLocation = locations.first
        }
        print(#function, "current location: \(self.currentLocation!)")
        self.doReverseGeocoding(location: self.currentLocation!, completionHandler: {_,_ in })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "error: \(error.localizedDescription)")
    }
    
    func doReverseGeocoding(location: CLLocation, completionHandler: @escaping(String?, NSError?) -> Void){
        var result  = ""
        
        self.geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if error != nil{
                //                Unable to get address for given coordinates
                completionHandler(nil, error as NSError?)
            }else{
                if let placemarkList = placemarks, let placemark = placemarkList.first{
                    //                    let city = placemark.locality ?? "NA"
                    //                    let province = placemark.administrativeArea ?? "NA"
                    //                    let country = placemark.country ?? "NA"
                    //                    let street = placemark.thoroughfare ?? "NA"
                    //
                    //                    result = "\(street), \(city), \(province), \(country)"
                    
                    //successfully obtained the placemark
                    result = CNPostalAddressFormatter.string(from: placemark.postalAddress!, style: .mailingAddress)
                    self.address = result
                    print(#function, "address : \(result)")
                    
                    completionHandler(result, nil)
                    return
                }
                completionHandler(nil, error as NSError?)
            }
        })
    }
    
    
    func doGeocoding(address: String, completionHandler: @escaping(CLLocation?, NSError?) -> Void){
        self.geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil{
                completionHandler(nil, error as NSError?)
            }else{
                if let placemark = placemarks?.first{
                    let location = placemark.location!
                    
                    print(#function, "location: ", location)
                    
                    completionHandler(location, nil)
                    return
                }
                completionHandler(nil, error as NSError?)
            }
        })
    }
    
    func addPinToMapView(mapView: MKMapView, coordinates: CLLocationCoordinate2D, title: String?){
        
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = coordinates
        
        if let title = title{
            mapAnnotation.title = title
        }else{
            mapAnnotation.title = self.address
        }
        
        mapView.addAnnotation(mapAnnotation)
    }
}

