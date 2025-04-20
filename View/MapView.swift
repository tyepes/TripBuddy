//
//  MapView.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//
import SwiftUI
import MapKit


struct MapView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var currentAdventure : Adventure
    @ObservedObject var viewModel : MapModelView
    let locationManager = CLLocationManager()
    
    @State var longPressedCoordinate: CLLocationCoordinate2D?
    @State var selectedMarker: TripLocation?
    @State var showAddTripSheet = false
    @State var showEditTripSheet = false

    
    @State var markers = []
    @State var route:  MKRoute?
    @State var searchText = ""
    var body: some View {
        
        NavigationStack {
            ZStack() {
                Map(initialPosition: .region(viewModel.region)) {
                    UserAnnotation()

                    ForEach(viewModel.markers) { marker in
                        Annotation(marker.name, coordinate: marker.coordinate) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .imageScale(.large)
                        }
                        
                    }
                    
                    if viewModel.markers.count > 1 {
                        MapPolyline(coordinates: viewModel.markers.map { $0.coordinate })
                            .stroke(.blue, lineWidth: 4)
                    }
                }
                    .ignoresSafeArea(edges: .bottom)
                    .onAppear {
                        locationManager.requestWhenInUseAuthorization()
                    }
                    .mapControls {
                        MapUserLocationButton()
                        MapCompass()
                        MapPitchToggle()
                        MapScaleView()
                    }
            }
            .navigationTitle("Current adventure: \(currentAdventure.adventureName)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                                Text("Test")
                        }
                        Button {
                            showAddTripSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.systemBackground))
                            .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4)
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                }
            }
            .sheet(isPresented: $showAddTripSheet) {
                AddTripView(viewModel: viewModel, region: $viewModel.region)
            }
        }
    }
}


#Preview {
    let sampleTrip = Trip(
        name: "Hiking Adventure",
        location: TripLocation(
            name: "McDowell Mountain",
            coordinate: CLLocationCoordinate2D(latitude: 33.651, longitude: -111.933)
        ),
        description: "Exploring the trails at McDowell Mountain."
    )
    let desertTrip = Trip(
            name: "Desert Camping",
            location: TripLocation(
                name: "Sonoran Desert",
                coordinate: CLLocationCoordinate2D(latitude: 33.4484, longitude: -112.0740)
            ),
            description: "A quiet night under the stars in the desert."
        )
    
    let island = Trip(
            name: "Desert Camping",
            location: TripLocation(
                name: "Sonoran Desert",
                coordinate: CLLocationCoordinate2D(latitude: 32.4484, longitude: -112.0740)
            ),
            description: "A quiet night under the stars in the desert."
        )
    


    let sampleAdventure = Adventure(
        adventureName: "Arizona Trip",
        TripList: [sampleTrip, desertTrip, island],
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!
    )

    let viewModel = MapModelView(adventure: sampleAdventure)

    return MapView(
        currentAdventure: sampleAdventure,
        viewModel: viewModel,
        markers: viewModel.markers,
        searchText: ""
    )
}

