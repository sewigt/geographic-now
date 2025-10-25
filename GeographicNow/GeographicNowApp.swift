//
//  GeographicNowApp.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import SwiftUI

@main
struct GeographicNowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LocationManager())
        }
    }
}
