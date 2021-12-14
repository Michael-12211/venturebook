//
//  NoteDetails.swift
//  VentureBook
//
//  Created by Anh Phan on 2021-11-27.
//

import SwiftUI

struct NoteDetails: View {
    var note: Note?

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var noteCDBHelper : NoteCDBHelper
    @EnvironmentObject var locationHelper : LocationHelper
    
    @State private var deleted = false;
    @State private var added = false;
    @State private var uploaded = 0;

    init(note: Note?){
        self.note = note
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor.init(Color.headerColor)]
    }
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 10){
                HStack(alignment: .top){
                    Image(uiImage: UIImage(data: note!.picture) ?? UIImage(named: "placeholder")!)
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .leading)
                    VStack (alignment: .leading, spacing: 10) {
                        Text(note!.title).fontWeight(.semibold).font(.title)
                        Text(note!.location)
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .topLeading
                    )
                }
                
                Text(note!.desc)
                Text(note!.posted, style: .date)
                .alert(isPresented: $added, content: {
                    Alert(title: Text("Post uploaded!"), message: Text("This post will be visible to other users"))
                })
                
                HStack(alignment: .center){
                    
                    if (uploaded == 0)
                    {
                        Button ("Share Note", action: {
                            
                            for (idx, obj) in self.noteCDBHelper.mNotes.enumerated()
                            {
                                if (obj.id == note!.id)
                                {
                                    self.noteCDBHelper.mNotes[idx].uploaded = 1
                                }
                            }
                            
                            print("Made note for uploading")
                            
                            fireDBHelper.insertNote(newNote: note!)
                            
                            uploaded = 1
                            added = true
                            //self.presentationMode.wrappedValue.dismiss()

                        })
                        .padding()
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                    }
                    
                    if (uploaded == 1)
                    {
                        Button ("Un-Share Note", action: {
                            
                            for (idx, obj) in self.noteCDBHelper.mNotes.enumerated()
                            {
                                if (obj.id == note!.id)
                                {
                                    self.noteCDBHelper.mNotes[idx].uploaded = 0
                                }
                            }
                            
                            fireDBHelper.deleteNote(noteToDelete: note!)
                            
                            print("removed note from firebase")
                            
                            uploaded = 0;
                            self.deleted = true;

                        })
                        .padding()
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                    }
                    
                    if (uploaded != 2)
                    {
                        Button (action:{
                            print ("Navigating to the edit notes screen")
                        }) {
                            NavigationLink("Edit Note", destination: EditNote(select: self.note!.id)) // Edit note
                        }
                        .padding()
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                        .disabled(note!.uploaded == 2)
                    }
                }
                .alert(isPresented: $deleted, content: {
                    Alert(title: Text("Post removed!"), message: Text("This post will no longer be shared with other users"))
                })
                
                Spacer()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(30)
        }
        .onAppear(){
            uploaded = note!.uploaded
            
            locationHelper.stopUpdatingLocation()
        }
        .onDisappear(){
            locationHelper.startUpdatingLocation()
        }
        
    }
}
