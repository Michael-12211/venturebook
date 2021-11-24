//
//  MyNotes.swift
//  VentureBook
//
//  Created by Michael Kempe on 2021-11-15.
//

import SwiftUI

struct MyNotes: View {
    
    @State private var selectedIndex : Int = -1
    @State private var selection : Int? = nil
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var noteCDBHelper : NoteCDBHelper
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor.init(Color.headerColor)]
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            //NavigationLink(destination: EditStuff(selected: self.selectedIndex), tag: 1, selection: $selection){}
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
                }
            }
            .onDelete(perform: { indexSet in
                for index in indexSet{
                    self.noteCDBHelper.deleteNote(noteID: self.noteCDBHelper.mNotes[index].id!)
                    self.noteCDBHelper.mNotes.remove(at: index)
                }
            })//onDelete
        }
        .navigationBarTitle("List of stuff", displayMode: .inline)
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
