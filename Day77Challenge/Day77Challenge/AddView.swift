//
//  AddView.swift
//  Day77Challenge
//
//  Created by M Sapphire on 2024/1/10.
//

import PhotosUI
import SwiftUI
import MapKit

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedPicture: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var peopleName: String = ""
    @State private var location: MapCameraPosition?
    
    var onSave: (Picture) -> Void
    let locationFetcher = LocationFetcher()
    
    init(onSave: @escaping (Picture) -> Void) {
        self.onSave = onSave
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                PhotosPicker(selection: $selectedPicture) {
                    if selectedImage == nil {
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .frame(width: 300, height: 200)
                            .padding()
                            .overlay(
                                Rectangle()
                                    .stroke()
                            )
                    } else {
                        selectedImage?
                            .resizable()
                            .scaledToFit()
                    }
                }
                .onChange(of: selectedPicture) {
                    Task {
                        if let image = try? await selectedPicture?.loadTransferable(type: Image.self) {
                            selectedImage = image
                        }
                    }
                }
                .padding(.bottom, 50)
                
                Section {
                    if let location = location {
                        Map(initialPosition: location) {
                            Marker(peopleName, coordinate: locationFetcher.lastKnownLocation!)
                        }
                        .frame(height: 200)
                    }
                    
                    Button("get Location") {
                        Task {
                            locationFetcher.start()
                            getPostion()
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)
                    .shadow(radius: 5)
                }
                .padding(.bottom, 30)
                
                Section {
                    TextField("enter name", text: $peopleName)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.capsule)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                HStack {
                    Section {
                        Button("Save") {
                            Task {
                                guard let data = try? await selectedPicture?.loadTransferable(type: Data.self) else { return }
                                guard let location = locationFetcher.lastKnownLocation else { return }
                                guard let locationData = try? JSONEncoder().encode(CooidinateInfo(location: location)) else { return }
                                let newPicture = Picture(pictureID: UUID(), pictureData: data, humanName: peopleName, lastKnownLocation: locationData)
                                onSave(newPicture)
                                dismiss()
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(.ultraThinMaterial)
                        .clipShape(.capsule)
                        .shadow(radius: 5)
                        .disabled(isSaveButtonAvaliable())
                    }
                    .padding(.trailing, 50)
                    
                    Section {
                        Button("Cancle") {
                            dismiss()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(.capsule)
                        .shadow(radius: 5)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Add people")
            .navigationBarTitleDisplayMode(.inline)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    func isSaveButtonAvaliable() -> Bool {
        if selectedImage == nil || peopleName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
    
    func getPostion() {
        guard let location = locationFetcher.lastKnownLocation else { return }
        self.location = MapCameraPosition.camera(MapCamera(centerCoordinate: location, distance: 500000))
    }
}

#Preview {
    AddView(onSave: {_ in})
}
