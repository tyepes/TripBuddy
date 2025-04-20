//
//  Adventure.swift
//  Phase1
//
//  Created by Tommy Yepes on 4/18/25.
//

import Foundation
import SwiftData


struct Adventure : Identifiable {
    var adventureName : String
    var TripList : [Trip]
    var startDate: Date
    var endDate: Date
    var description: String
    var id = UUID()
    
    mutating func addTripToAdventure(_ name : String,_ location : TripLocation, _ description : String) {
        let newTrip = Trip(name: name, location: location, description: description)
        TripList.append(newTrip)
    }
    mutating func deleteTripfromAdventure(_ index : Int) {
        TripList.remove(at: index)
    }
    
    func dateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date1 = formatter.string(from: startDate)
        let date2 = formatter.string(from: endDate)
        return date1 + " - " + date2
    }
    
}
