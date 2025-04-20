//
//  MapModelView.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//

import Foundation
import MapKit

class MapModelView : ObservableObject {
    @Published var adventure : Adventure
    @Published var region : MKCoordinateRegion
    @Published var markers : [TripLocation]
    init(adventure: Adventure) {
        self.adventure = adventure
        var markers  : [TripLocation] = []
        for item in adventure.TripList {
            markers.append(item.location)
        }
        self.markers = markers
        if adventure.TripList.isEmpty {
            self.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 33.4255, longitude: -111.9400),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
        else {
            self.region = MKCoordinateRegion(
                center: adventure.TripList[0].location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
    }
    
    func getDirections(from source : CLLocationCoordinate2D, to destination : CLLocationCoordinate2D) async -> MKRoute {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: source))
        request.destination = MKMapItem(placemark: .init(coordinate: destination))
        request.transportType = .automobile
        
        do {
            let directions = try await MKDirections(request: request).calculate()
            return directions.routes.first!
        }
        catch {
            print("error")
        }
        return MKRoute()
    }
    
}
