//
//  LocationManager.swift
//  GeographicNow
//
//  Created by sewig on 2025/10/04.
//

import Foundation
import CoreLocation
internal import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var isRunning: Bool = false
    @Published var latitude: CLLocationDegrees? = nil
    @Published var longitude: CLLocationDegrees? = nil
    @Published var address: String? = nil
    @Published var message: String? = nil
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.allowsBackgroundLocationUpdates = false
        message = ""
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            if status == .notDetermined {
                self.locationManager.requestWhenInUseAuthorization()
            } else if status == .authorizedAlways || status == .authorizedWhenInUse {
                self.message = ""
                if self.isRunning {
                    self.locationManager.startUpdatingLocation()
                }
            } else if status == .denied {
                self.latitude = nil
                self.longitude = nil
                self.address = nil
                self.message = String(localized: "ErrorDenied")
            } else if status == .restricted {
                self.latitude = nil
                self.longitude = nil
                self.address = nil
                self.message = String(localized: "ErrorRestricted")
            }
            self.isRunning = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.isRunning {
            return
        }
        self.isRunning = false
        if let location = locations.last {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            Task {
                do {
                    self.address = try await GeolocationService.getAddress(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    self.message = String(localized: "Success")
                } catch {
                    self.message = String(localized: "Error")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.message = String(localized: "Error")
        locationManager.stopUpdatingLocation()
        DispatchQueue.main.async {
            self.latitude = nil
            self.longitude = nil
            self.address = nil
            self.isRunning = false
        }
    }
    
    func startUpdatingLocation() {
        if (isRunning) {
            return
        }
        isRunning = true
        DispatchQueue.global().async {
            if !CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.isRunning = false
                    self.message = String(localized: "Error")
                }
                return
            }
            switch CLLocationManager().authorizationStatus {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                DispatchQueue.main.async {
                    self.isRunning = false
                    self.message = String(localized: "Error")
                }
            case .authorizedAlways, .authorizedWhenInUse:
                DispatchQueue.main.async {
                    self.message = String(localized: "Running")
                    self.locationManager.requestWhenInUseAuthorization()
                    self.locationManager.startUpdatingLocation()
                }
            @unknown default:
                break
            }
        }
    }
}
