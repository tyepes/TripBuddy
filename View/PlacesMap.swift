//
//  PlacesMap.swift
//  Phase1
//
//  Created by Tommy Yepes on 4/19/25.
//

import SwiftUI
import MapKit

struct PlacesMapView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var region: MKCoordinateRegion
    @StateObject private var viewModel = PlacesClientVM()
    @State private var searchText = ""
    @State private var searchKeyword = ""
    @State private var showingPlaceDetails = false
    
    @Binding var location: TripLocation
    
   
    
    var body: some View {
        VStack {
            // Search bar
            HStack {
                TextField("Enter location", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                TextField("Keyword (optional)", text: $searchKeyword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button("Search") {
                    viewModel.searchPlacesByAddress(address: searchText, keyword: searchKeyword)
                }
                .padding(.trailing)
            }
            .padding(.top)
            
            // Map view
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.places) { place in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                        
                        Text(place.name)
                            .font(.caption)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(4)
                    }
                    .onTapGesture {
                        viewModel.selectPlace(place)
                        showingPlaceDetails = true
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $showingPlaceDetails) {
            if let selectedPlace = viewModel.selectedPlace {
                PlaceDetailView(place: selectedPlace, location: $location)
            }            
        }
        .onAppear {
            viewModel.region = region
        }
    }
}

struct PlaceDetailView: View {
    var place: Place
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var location: TripLocation
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                Text(place.name)
                    .font(.title)
                    .bold()
                
                Text(place.vicinity ?? "No address provided")
                    .font(.subheadline)
                
                if let rating = place.rating {
                    HStack {
                        Text("Rating: \(rating, specifier: "%.1f")")
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        if let total = place.userRatingsTotal {
                            Text("(\(total) reviews)")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
//                if let types = place.types {
//                    Text("Categories: \(types.joined(separator: ", "))")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
                
                if let priceLevel = place.priceLevel {
                    Text("Price level: \(String(repeating: "$", count: priceLevel))")
                }
                
                if let isOpen = place.openingHours?.openNow {
                    Text(isOpen ? "Open now" : "Closed")
                        .foregroundColor(isOpen ? .green : .red)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                Button("Add to Trip") {
                    location.name = place.name
                    location.coordinate.latitude = place.geometry.location.lat
                    location.coordinate.longitude = place.geometry.location.lng
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .navigationBarTitle("Place Details", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
//    PlacesMapView()
}
