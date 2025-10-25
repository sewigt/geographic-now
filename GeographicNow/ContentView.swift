//
//  ContentView.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var location: LocationManager
    @State var selectedTab: Int = 0
    var body: some View {
        TabView{
            MainView()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                }
            if (location.latitude != nil && location.longitude != nil) {
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                    }
            }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
