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
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var description = ""
    @State private var trip = "none"
    @State private var picture: Data? = nil
    
    @State private var trips = [String]()
    
    @State private var permissionGranted: Bool = false
    @State private var image: UIImage?
    @State private var showSheet: Bool = false
    @State private var showPicker: Bool = false
    @State private var isUsingCamera: Bool = false
    
    var body: some View {
        VStack {
            HStack
            {
                Text("Title: ")
                TextField("title", text: self.$title)
            }
            Image(uiImage: image ?? UIImage(named: "placeholder")!)
                .resizable()
                .frame(width: 300, height: 300)
            Button(action:{
                if (permissionGranted){
                    self.showSheet = true
                }else{
                    self.requestPermissions()
                }
            }){
                Text("Upload Photo")
                    .padding()
            }
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
            
            HStack
            {
                Text("Trip:")
                    .padding(.leading, 50.0)
                Picker("Please choose trip", selection: $trip){
                ForEach(trips, id: \.self) {
                    Text($0)
                }
                    
            }
            .frame(height: 250.0)
                .pickerStyle(WheelPickerStyle())                    }
            .navigationBarTitle("Place Reservation", displayMode: .inline)
            
            Text("Description:")
            ZStack //allows enterring a multi-line description
            {
                TextEditor(text: $description)
                Text(description).opacity(0).padding(.all, 8)
            }
            
            Button(action:{
                addNote()
            }){
                Text("Add note")
            }
        }
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
    
    private func addNote()
    {
        //TODO
        //once the picture can be added, save to coreDB
        self.presentationMode.wrappedValue.dismiss()
        
        // Firebase integration testing
        let newNote = Note(title:title, desc:description)
        fireDBHelper.insertNote(newNote: newNote)
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
