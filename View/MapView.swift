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
                            showEditTripSheet = true
                        } label: {
                                Text("History")
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
            .sheet(isPresented: $showEditTripSheet) {
                    TripDetailView(viewModel: viewModel)
            }
        }
    }
}




