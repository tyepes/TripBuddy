//
//  Trip.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//
import Foundation
import MapKit
import SwiftData


struct Trip:Identifiable {
    var name:String
    var location:TripLocation
    var description:String
    var id = UUID()
}
