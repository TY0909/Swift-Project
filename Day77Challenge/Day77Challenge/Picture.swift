//
//  Picture.swift
//  Day77Challenge
//
//  Created by M Sapphire on 2024/1/10.
//
import CoreLocation
import Foundation
import SwiftData

struct CooidinateInfo: Codable {
    var latitude: Double
    var longitude: Double
    
    init(location: CLLocationCoordinate2D) {
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
}
@Model
class Picture: Comparable, Identifiable {
    let pictureID: UUID
    let pictureData: Data
    let humanName: String
    var lastKnownLocation: Data
    
    init(pictureID: UUID, pictureData: Data, humanName: String, lastKnownLocation: Data) {
        self.pictureID = pictureID
        self.pictureData = pictureData
        self.humanName = humanName
        self.lastKnownLocation = lastKnownLocation
    }
    
    static func <(lhs: Picture, rhs: Picture) -> Bool{
        lhs.humanName < rhs.humanName
    }
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
