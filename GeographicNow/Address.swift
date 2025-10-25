//
//  Address.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import SwiftUI

struct Address: Decodable {
    var country_code: String?
    var state: String?
    var region: String?
    var province: String?
    var district: String?
    var subdistrict: String?
    var county: String?
    var municipality: String?
    
    var city: String?
    var borough: String?
    var suburb: String?
    var quarter: String?
    var neighbourhood: String?
    
    var town: String?
    var village: String?
}
