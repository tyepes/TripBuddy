//
//  TripDetailView.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//

import SwiftUI

struct TripDetailView : View {
    @ObservedObject var viewModel : MapModelView
    
    func deleteTrip(at offsets: IndexSet) {
        viewModel.adventure.TripList.remove(atOffsets: offsets)
        }
    
    var body: some View {
        VStack {
            Text(viewModel.adventure.adventureName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text(viewModel.adventure.description)
            List {
                ForEach(viewModel.adventure.TripList) {trip in
                    TripCard(trip: trip)
                }
                .onDelete(perform: deleteTrip)
            }
        }
        .toolbar {
            EditButton()
        }
    }
}

struct TripCard : View {
    
    let trip: Trip
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(trip.name)
                    Text(trip.description)
                }
            }
        }
        .padding()
    }
}
