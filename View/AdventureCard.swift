//
//  AdventureCard.swift
//  Phase1
//
//  Created by Tommy Yepes on 4/18/25.
//
import SwiftUI

struct AdventureCard: View {
    let adventure: Adventure
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(adventure.adventureName)
                    Text(adventure.dateFormatted())
                }
            }
        }
        .padding()
    }
}
