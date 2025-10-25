//
//  MainView.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var location: LocationManager
    
    @AppStorage("StorageEnableDistance") var storageEnableDistance: Bool = true
    @AppStorage("StorageEnableMapURL") var storageEnableMapURL: Bool = true
    @AppStorage("StoragePrefix") var storagePrefix: String = String(localized: "HintPrefix")
    @AppStorage("StorageSuffix") var storageSuffix: String = String(localized: "HintSuffix")
    @AppStorage("StorageShareCount") var storageShareCount: Int = 0
    @AppStorage("StorageTotalDistance") var storageTotalDistance: Int = 0
    @AppStorage("StorageLastLatitude") var storageLatitude: Double = Double.nan
    @AppStorage("StorageLastLongitude") var storageLongitude: Double = Double.nan
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Latitude")
                        .padding()
                    if let latitude = location.latitude {
                        Text(String(latitude))
                            .padding()
                    } else {
                        Text("None")
                            .padding()
                    }
                }
                
                HStack {
                    Text("Longitude")
                        .padding()
                    if let longitude = location.longitude {
                        Text(String(longitude))
                            .padding()
                    } else {
                        Text("None")
                            .padding()
                    }
                }
                
                HStack {
                    Text("Address")
                        .padding()
                    if let address = location.address {
                        Text(address)
                            .padding()
                    } else {
                        Text("None")
                            .padding()
                    }
                }
                
                Button(action: {
                    location.startUpdatingLocation()
                }, label: {
                    Text("GetLocation")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                })
                .background(.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(location.isRunning)
                .padding()
                
                if let message = location.message {
                    Text(message)
                        .padding()
                }
                
                if (location.address != nil) {
                    Button(action: {
                        var text = storagePrefix + location.address! + storageSuffix
                        guard let distance = LocationService.getDistance(latitudeBefore: storageLatitude, longitudeBefore: storageLongitude, latitudeAfter: location.latitude!, longitudeAfter: location.longitude!) else {
                            return
                        }
                        storageTotalDistance += Int(distance)
                        if (storageEnableDistance) {
                            let fromLastDistance = String(localized: "FromLastDistance")
                            let unit = String(localized: "UnitDistance")
                            text += " (\(fromLastDistance) \(distance) \(unit))"
                        }
                        if (storageEnableMapURL) {
                            let locationString = LocationService.getLocationString(latitude: location.latitude!, longitude: location.longitude!)
                            text += " \(locationString)"
                        }
                        storageLatitude = location.latitude!
                        storageLongitude = location.longitude!
                        storageShareCount += 1
                        if let url = ShareService.getShareUrl(text: text) {
                            print(url.absoluteString)
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Text("ShareLocation")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    })
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}
