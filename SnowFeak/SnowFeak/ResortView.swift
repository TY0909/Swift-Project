//
//  ResortView.swift
//  SnowFeak
//
//  Created by M Sapphire on 2024/2/1.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var horizontalSize
    @Environment(\.dynamicTypeSize) var typeSize
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Image(resort.country)
                        .resizable()
                        .scaledToFit()
                    Text("Resouce: \(resort.imageCredit)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .font(.footnote)
                }
                
                HStack {
                    if horizontalSize == .compact {
                        VStack(spacing: 10) { SkiDetailView(resort: resort) }
                        VStack(spacing: 10) { ResortDetailView(resort: resort) }
                    } else {
                        SkiDetailView(resort: resort)
                        ResortView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                    
                    Text("Facilirties")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility.toggle()
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites")  {
                        if favorites.contains(resort) {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: Resort.resortExample)
        .environmentObject(Favorites())
}
