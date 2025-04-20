//
//  AddAdventureView.swift
//  Phase1
//
//  Created by Tommy Yepes on 4/18/25.
//

import SwiftUI

struct AddAdventureView : View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var adventures : AdventureList
    @State var adventureName : String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var description : String = ""
    
    var body: some View {
        VStack (spacing: 30) {
            Text("Enter New Adventure")
                .font(.largeTitle)
            TextField("Adventure Name", text: $adventureName)
                .padding(.horizontal)
            HStack (spacing: 20.0) {
                DatePicker("",
                           selection: $startDate,
                           displayedComponents: .date
                )
                DatePicker("",
                           selection: $endDate,
                           displayedComponents: .date
                )
            }
            TextField("description", text: $description)
                .padding(.horizontal)
            Button("Submit", action: {
                adventures.createAdventure(adventureName, startDate, endDate, description)
                dismiss()
            })
            .buttonStyle(.bordered)
        }
        .textFieldStyle(.roundedBorder)
        .padding(.vertical, 30)
        
        .padding(.horizontal, 30)
        
    }
}
//#Preview {
//    AddAdventureView()
//}
