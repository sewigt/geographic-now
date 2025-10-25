//
//  LocationService.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import Foundation
import CoreLocation

class LocationService {
    static let EQUATORIAL_RADIUS: Double = 6378137
    
    static func getDistance(latitudeBefore: CLLocationDegrees, longitudeBefore: CLLocationDegrees, latitudeAfter: CLLocationDegrees, longitudeAfter: CLLocationDegrees) -> Double? {
        if (!latitudeBefore.isNaN && !longitudeBefore.isNaN) {
            let latitudeRadianDifference = convert(degree: latitudeAfter - latitudeBefore)
            let longitudeRadianDifference = convert(degree: longitudeAfter - longitudeBefore)
            let latitudeRadian = convert(degree: latitudeBefore)
            let longitudeRadian = convert(degree: latitudeAfter)
            let a = sin(latitudeRadianDifference / 2.0) * sin(latitudeRadianDifference / 2.0) + sin(longitudeRadianDifference / 2.0) * sin(longitudeRadianDifference / 2.0) * cos(latitudeRadian) * cos(longitudeRadian)
            return EQUATORIAL_RADIUS * 2.0 * atan2(sqrt(a), sqrt(1.0 - a))
        }
        return nil
    }
    
    static func getLocationString(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        return "https://maps.google.com/maps?@\(latitude),\(longitude),15z"
    }
        
    static func convert(degree: Double) -> Double {
        return degree * Double.pi / 180.0
    }
}
