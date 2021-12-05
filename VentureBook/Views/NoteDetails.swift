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
                HStack(alignment: .center){
                    Button ("Share Note", action: {
                        let noteToUpload = Note(
                            id: self.note!.id,
                            title: self.note!.title,
                            desc: self.note!.desc,
                            location: self.note!.location,
                            posted: self.note!.posted,
                            picture: self.note!.picture
                        )
                        
                        fireDBHelper.insertNote(newNote: noteToUpload)
                        
                        self.presentationMode.wrappedValue.dismiss()

                    })
                    .padding()
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                    
                    Button (action:{
                        print ("Navigating to the my notes screen")
                    }) {
                        NavigationLink("Edit Note", destination: EditNote(select: self.note!.id)) // Edit note
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.buttonColor))
                    .disabled(note!.uploaded == 2)
                }
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
        
    }
}
