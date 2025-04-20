//
//  TripListView.swift
//  Phase1
//
//  Created by Tommy Yepes on 3/30/25.
//

import SwiftUI
import MapKit

struct TripListView : View {
    @ObservedObject var adventures : AdventureList
    
    @State var selectedAdventure: UUID? = nil
    @State var showAddAdventureView : Bool = false
    @State var showMapView : Bool = false
    
    func deleteAdventure(at offsets: IndexSet) {
            adventures.adventures.remove(atOffsets: offsets)
        }

    var body: some View {
        NavigationStack {
            VStack {
                Text("Adventure Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("select or enter a new adventure")
                List {
                    ForEach(adventures.adventures) { card in
                        AdventureCard(adventure: card)
                        NavigationLink {
                            MapView(currentAdventure: card, viewModel: MapModelView(adventure: card) )
                                    } label: {
                                        HStack {
                                            
                                            Text("View on Map")
                                            Image(systemName: "globe")
                                                .imageScale(.small)
                                                .foregroundColor(.accentColor)
                                        }
                                        .padding()
                                    }
                    }
                    .onDelete(perform: deleteAdventure)
                }
                Spacer()
                Button("Add", action: {
                    showAddAdventureView = true
                })
            }
            .toolbar {
                EditButton()
            }
            .sheet(isPresented: $showAddAdventureView) {
                AddAdventureView(adventures: adventures)
            }
        }
    }
}
