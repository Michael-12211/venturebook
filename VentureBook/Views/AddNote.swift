//
//  AddNote.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-11-06.
//

import SwiftUI
import PhotosUI

struct AddNote: View {
    
    @EnvironmentObject var noteCDBHelper : NoteCDBHelper
    @EnvironmentObject var tripCDBHelper : TripCDBHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var locationHelper : LocationHelper
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var description = ""
    @State private var trip = "none"
    
    @State private var trips = [String]()
    
    @State private var permissionGranted: Bool = false
    @State private var image: UIImage?
    @State private var showSheet: Bool = false
    @State private var showPicker: Bool = false
    @State private var isUsingCamera: Bool = false
    
    @State private var loc: String = ""
    
    init(){
        UITableView.appearance().backgroundColor = .clear

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor.init(Color.headerColor)]
    }
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
        Form {
            
            //VStack {
            Section {
                
                HStack {
                    Text("Title: ")
                    TextField("title", text: self.$title)
                }.foregroundColor(Color.headerColor)
            }
            Section {
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .frame(width: 200, height: 100)
                Button(action:{
                    if (permissionGranted){
                        self.showSheet = true
                    }else{
                        self.requestPermissions()
                    }
                }){
                    Text("Upload Photo")
                        .padding()
                }.foregroundColor(Color.headerColor)
                .actionSheet(isPresented: $showSheet){
                    ActionSheet(title: Text("Select Photo"),
                                message: Text("Choose the photo to upload"),
                                buttons: [
                                    .default(Text("Choose from Photo Library")){
                                        self.showPicker = true
                                    },
                                    .default(Text("Take a new pic from Camera")){
                                        guard UIImagePickerController.isSourceTypeAvailable(.camera) else{
                                            
                                            print(#function, "Camera is not accessible")
                                            return
                                        }
                                        self.isUsingCamera = true
                                        self.showPicker = true
                                    },
                                    .cancel()
                                ])
                }
                .fullScreenCover(isPresented: $showPicker){
                    if (isUsingCamera){
                        CameraPicker(image: self.$image, isPresented: self.$isUsingCamera)
                    }else{
                        LibraryPicker(selectedImage: self.$image, isPresented: self.$showPicker)
                    }
                }
            }
                
            Section {
                HStack
                {
                    Text("Trip:")
                        .padding(.leading, 0.0)
                    Picker("Please choose trip", selection: $trip){
                    ForEach(trips, id: \.self) {
                        Text($0)
                        }
                    }
                }.foregroundColor(Color.headerColor)
                .navigationBarTitle("Place Reservation", displayMode: .inline)
            }
                
            Section {
                Text("Description:")
                    .foregroundColor(Color.headerColor)
                ZStack //allows enterring a multi-line description
                {
                    TextEditor(text: $description)
                    Text(description).opacity(0).padding(.all, 8)
                }
            }
                
            Section {
                Button(action:{
                    addNote()
                }){
                    Text("Add note")
                }.foregroundColor(Color.headerColor)
            }
            //} //VStack
            
        }.background(Color.backgroundColor) //Form
        .onAppear(){
            self.tripCDBHelper.getAllTrips()
            if (tripCDBHelper.mTrips.count > 0)
            {
                for nTrip in tripCDBHelper.mTrips
                {
                    trips.append(nTrip.title)
                }
                trip = tripCDBHelper.mTrips[0].title
            }
            else
            {
                trips.append("none")
            }
            self.checkPermissions()
        }
    }
    }
    private func addNote()
    {
        
        if (self.locationHelper.currentLocation != nil)
        {
            print ("current location found")
            
            let location = locationHelper.currentLocation!
            
            self.locationHelper.doReverseGeocoding(location: location, completionHandler: { (address, error) in
                
                if (error == nil && address != nil){
                    //sucessfully obtained coordinates
                    loc = address!
                    
                    print(#function, "Address obtained : \(address!)")
                    
                    saveNote()
                }else{
                    loc = "Fail"
                    print(#function, "error: ", error?.localizedDescription as Any)
                }
            })
        }
    }
    
    private func saveNote ()
    {
        var picture = UIImage(named: "placeholder")!.pngData();
        
        if (image != nil)
        {
            picture = image!.pngData()
        }
        
        if(loc != "Fail")
        {
            let note = Note(title: title, desc: description, trip: trip, picture: picture!, location: loc)
            
            self.noteCDBHelper.insertNote(note: note)
        
            self.presentationMode.wrappedValue.dismiss()
        }
        else //Since two of the group members developing this project cannot load their apps onto phones for testing of location, alternate implementations can be put here such that other functionalities can be tested. Code placed here must be deleted prior to the final app
        {
            print ("The location couldn't properly be handled \n")
        }
        
    }
    
    private func checkPermissions(){
        switch PHPhotoLibrary.authorizationStatus(){
        case .authorized:
            self.permissionGranted = true
        case .notDetermined:
            return
        case .denied:
            return
        case .restricted:
            return
        case .limited:
            break
        @unknown default:
            break
        }
    }
    
    private func requestPermissions(){
        PHPhotoLibrary.requestAuthorization{status in
            switch status{
            case .authorized:
                self.permissionGranted = true
            case .denied:
                return
            case .limited:
                return
            case .notDetermined:
                return
            case .restricted:
                return
            @unknown default:
                return
            }
        }
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}
