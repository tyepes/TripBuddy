//
//  TripListModelView.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//

import Foundation

class AdventureList: ObservableObject {
    @Published var adventures: [Adventure] = []
    
    func createAdventure(_ name: String, _ startDate: Date, _ endDate: Date, _ description: String) {
        let newAdventure = Adventure(adventureName: name, TripList: [], startDate: startDate, endDate: endDate, description: description)
        adventures.append(newAdventure)
    }
    func deleteAdventure(_ index : Int) {
        adventures.remove(at: index)
    }
}
