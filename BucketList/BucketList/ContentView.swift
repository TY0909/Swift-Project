//
//  ContentView.swift
//  BucketList
//
//  Created by M Sapphire on 2023/12/30.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.isUnlocked {
                ZStack {
                    Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                
                                Text(location.name)
                            }
                            .onTapGesture {
                                viewModel.selectedPlace = location
                            }
                        }
                    }
                    .ignoresSafeArea()
                    
                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                viewModel.addLocation()
                                viewModel.save()
                            } label: {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(.black.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                            
                        }
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(viewModel: EditView.EditViewModel(location: place) { newLocation in
                        viewModel.update(newLocation: newLocation)
                        viewModel.save()
                    })
                }
            } else {
                Button("Unlock") {
                    viewModel.authenicate()
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert) {
            Button("ok") {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
