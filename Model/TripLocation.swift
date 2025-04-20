//
//  TripLocation.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//

import Foundation
import MapKit

struct TripLocation: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
