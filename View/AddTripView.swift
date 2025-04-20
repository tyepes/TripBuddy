//
//  AddTripView.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//

import SwiftUI
import MapKit

struct AddTripView : View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel : MapModelView
    
    @State var showAddMapView : Bool = false
    @State var showRecommendationsMap : Bool = false
    
    @State var name : String = ""
    @State var location : TripLocation = TripLocation(name: "temp", coordinate: CLLocationCoordinate2D(latitude: 33.651, longitude: -111.933))
    @State var description : String = ""
    
    @Binding var region : MKCoordinateRegion
    
    var body: some View {
        VStack (spacing: 30) {
            Text("Enter new trip")
                .font(.largeTitle)
            TextField("Name", text: $name)
                .padding(.horizontal)
            HStack {
                Button("Enter custom location on map") {
                    showAddMapView = true
                }
                Button("Get recommendations on map") {
                    showRecommendationsMap = true
                }
            }
            TextField("description", text: $description)
                .padding(.horizontal)
            Button("Submit", action: {
                let newTrip = Trip(name: name, location: location, description: description)
                viewModel.adventure.TripList.append(newTrip)
                viewModel.markers.append(newTrip.location)
                dismiss()
            })
            .buttonStyle(.bordered)
        }
        .textFieldStyle(.roundedBorder)
        .padding(.vertical, 30)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4)
                
        )
        .padding(.horizontal, 30)
        .sheet(isPresented: $showAddMapView) {
            AddTripMap(region: $region, location: $location, locationName: $name)
        }
        .sheet(isPresented: $showRecommendationsMap) {
            PlacesMapView(region: $region, location: $location)
        }
    }
}

struct AddTripMap: View {
    @Environment(\.dismiss) var dismiss
    @Binding var region: MKCoordinateRegion
    @Binding var location: TripLocation
    @Binding var locationName : String

    @State private var selectedCoordinate: CLLocationCoordinate2D?

    var body: some View {
        VStack {
            CoordinatePickerMap(region: $region, selectedCoordinate: $selectedCoordinate)
                .ignoresSafeArea(edges: .all)

            if let coordinate = selectedCoordinate {
                Button("Confirm Location") {
                    location = TripLocation(name: locationName, coordinate: coordinate)
                    dismiss()
                }
                .padding()
                .buttonStyle(.borderedProminent)
            } else {
                Text("Tap map to select location")
                    .padding()
            }
        }
    }
}


struct CoordinatePickerMap: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var selectedCoordinate: CLLocationCoordinate2D?

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CoordinatePickerMap

        init(parent: CoordinatePickerMap) {
            self.parent = parent
        }

        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let mapView = gestureRecognizer.view as! MKMapView
            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            parent.selectedCoordinate = coordinate
            
            mapView.removeAnnotations(mapView.annotations) // Remove previous pin
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = "Selected Location"
                        mapView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: false)
        
        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(gesture)
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: false)
        
        // Show annotation if selectedCoordinate already exists
                if let coordinate = selectedCoordinate {
                    uiView.removeAnnotations(uiView.annotations)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "Selected Location"
                    uiView.addAnnotation(annotation)
                }
    }
}



//#Preview {
//}
