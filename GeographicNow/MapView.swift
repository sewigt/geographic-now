//
//  MapView.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var location: LocationManager
    private let defaultLatitude: CLLocationDegrees = 37.332
    private let defaultLongitude: CLLocationDegrees = -122.031
    
    var body: some View {
        Map() {
            Marker("CurrentLocation", coordinate:
                CLLocationCoordinate2D(
                    latitude: location.latitude ?? defaultLatitude,
                    longitude: location.longitude ?? defaultLongitude
                )
            )
        }
        .mapControls {
            MapUserLocationButton()
        }
    }
}
