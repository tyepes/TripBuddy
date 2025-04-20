//
//  ActivityRecommendation.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//

import Foundation
import MapKit

struct ActivityRecommendation: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var coordinates: CLLocationCoordinate2D
    var description: String
}
