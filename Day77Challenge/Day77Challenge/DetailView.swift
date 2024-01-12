//
//  DetailView.swift
//  Day77Challenge
//
//  Created by M Sapphire on 2024/1/10.
//
import CoreLocation
import SwiftData
import SwiftUI
import MapKit

struct DetailView: View {
    var picture: Picture
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Image(uiImage: getImage(picture.pictureData))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                Section {
                    Map(initialPosition: getmapCameraPostion()) {
                        Marker(picture.humanName , coordinate: getCoordinate())
                    }
                    .frame(height: 200)
                    .overlay(
                        Rectangle()
                            .stroke(lineWidth: 1)
                    )
                }
                .padding(.bottom, 30)
                
                Text("Name: \(picture.humanName)")
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle(picture.humanName)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
    
    func getImage(_ data: Data) -> UIImage {
        guard let img = UIImage(data: picture.pictureData) else { fatalError() }
        return img
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        guard let data = try? JSONDecoder().decode(CooidinateInfo.self, from: picture.lastKnownLocation) else { fatalError() }
        let location = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
        return location
    }
    
    func getmapCameraPostion() -> MapCameraPosition {
        let location = getCoordinate()
        let mPosition = MapCamera(centerCoordinate: location, distance: 500000)
        return MapCameraPosition.camera(mPosition)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    guard let container = try? ModelContainer(for: Picture.self, configurations: config) else { fatalError("error")}
    let img = UIImage(systemName: "photo")
    guard let data = img?.pngData() else { fatalError() }
    let location = CLLocationCoordinate2D(latitude: 50, longitude: 80)
    guard let coordinateData = try? JSONEncoder().encode(CooidinateInfo(location: location)) else { fatalError() }
    let picture = Picture(pictureID: UUID(), pictureData: data, humanName: "name", lastKnownLocation: coordinateData)
    return DetailView(picture: picture)
        .modelContainer(container)
}
