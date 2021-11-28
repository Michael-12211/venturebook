//
//  NoteDetails.swift
//  VentureBook
//
//  Created by Anh Phan on 2021-11-27.
//

import SwiftUI

struct NoteDetails: View {
    var note: Note?
    
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
