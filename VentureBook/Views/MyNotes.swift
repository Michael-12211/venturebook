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
    @EnvironmentObject var coreDBHelper : NoteCDBHelper
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

/*struct MyNotes_Previews: PreviewProvider {
    static var previews: some View {
        MyNotes()
    }
}*/
