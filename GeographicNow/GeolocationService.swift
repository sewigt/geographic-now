//
//  GeolocationService.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import Foundation
import CoreLocation

class GeolocationService {
    static func getGeolocationUrl(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
        return URL(string: String(format:"https://nominatim.openstreetmap.org/reverse?lat=%f&lon=%f&format=json", latitude, longitude))
    }
    
    static func getAddress(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> String? {
        guard let url = getGeolocationUrl(latitude: latitude, longitude: longitude) else {
            return nil
        }
        var address: String? = nil
        async let (data, _) = URLSession.shared.data(for: URLRequest(url: url))
        let entity = try! await JSONDecoder().decode(Entity.self, from: data)
        var items: [String] = []
        if (entity.address.state != nil) {
            items.append(entity.address.state!)
        }
        if (entity.address.region != nil) {
            items.append(entity.address.region!)
        }
        if (entity.address.province != nil) {
            items.append(entity.address.province!)
        } else if (entity.address.country_code == "jp") {
            items.append("東京都")
        }
        if (entity.address.district != nil) {
            items.append(entity.address.district!)
        }
        if (entity.address.subdistrict != nil) {
            items.append(entity.address.subdistrict!)
        }
        if (entity.address.county != nil) {
            items.append(entity.address.county!)
        }
        if (entity.address.municipality != nil) {
            items.append(entity.address.municipality!)
        }
        
        if (entity.address.city != nil) {
            items.append(entity.address.city!)
        }
        if (entity.address.borough != nil) {
            items.append(entity.address.borough!)
        }
        if (entity.address.suburb != nil) {
            items.append(entity.address.suburb!)
        }
        if (entity.address.quarter != nil) {
            items.append(entity.address.quarter!)
        }
        if (entity.address.neighbourhood != nil) {
            items.append(entity.address.neighbourhood!)
        }
        
        if (entity.address.town != nil) {
            items.append(entity.address.town!)
        }
        if (entity.address.village != nil) {
            items.append(entity.address.village!)
        }
        if (entity.address.country_code == "jp") {
            address = items.joined()
        } else {
            address = items.joined(separator: " ")
        }
        
        return address
    }
}
