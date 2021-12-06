//
//  MyNotes.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-11-15.
//

import SwiftUI

struct MyNotes: View {
    let trip : String
    
    @State private var selectedIndex : Int = -1
    @State private var selection : Int? = nil
    
    @State private var selectedNote : Note? = nil
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var noteCDBHelper : NoteCDBHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    init(trip: String){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor.init(Color.headerColor)]
        self.trip = trip
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            //NavigationLink(destination: EditStuff(selected: self.selectedIndex), tag: 1, selection: $selection){}
            NavigationLink(destination: NoteDetails(note: selectedNote), tag: 1, selection: $selection){}
        List {
            ForEach (self.noteCDBHelper.mNotes.enumerated().map({$0}), id: \.element.self) { indx, note in
                VStack(alignment: .leading){
                    HStack
                    {
                        Image(uiImage: UIImage(data: note.picture) ?? UIImage(named: "placeholder")!)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .leading)
                        Text("\(note.title)")
                    }
                }
                .onTapGesture {
                    self.selectedIndex = indx
                    self.selection = 1
                    self.selectedNote = self.noteCDBHelper.mNotes[selectedIndex == -1 ? 0 : selectedIndex].convertToNote()
                }
            }
            .onDelete(perform: { indexSet in
                for index in indexSet{
                    
                    if (self.noteCDBHelper.mNotes[index].uploaded == 1)
                    {
                        self.fireDBHelper.deleteNote(noteToDelete: noteCDBHelper.mNotes[index].convertToNote())
                    }
                    
                    self.noteCDBHelper.deleteNote(noteID: self.noteCDBHelper.mNotes[index].id!)
                    self.noteCDBHelper.mNotes.remove(at: index)
                }
            })//onDelete
        }
        .navigationBarTitle("My Posts", displayMode: .inline)
        }
        .onAppear(){
            self.noteCDBHelper.getAllNotes()
        }
        .onDisappear(){self.noteCDBHelper.getAllNotes()}
    }
}

/*struct MyNotes_Previews: PreviewProvider {
    static var previews: some View {
        MyNotes()
    }
}*/
