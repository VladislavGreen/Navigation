//
//  LocationManager.swift
//  Navigation
//
//  Created by Vladislav Green on 2/20/23.
//

import UIKit
import CoreLocation


extension NSNotification.Name {
    static let sharedLocation = NSNotification.Name("sharedLocation")
}


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    private let notificationCenter = NotificationCenter.default
    
    private override init() { }
    
    
    func setupLocationManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func authorizationStatus() -> CLAuthorizationStatus {
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = CLLocationManager().authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        return status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let object: [String: Any] = [
                "error": false,
                "location": location
            ]
            
            DispatchQueue.main.async {
                self.setupNotificationCenter(object: object)
            }
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            print("Определение локации невозможно")
        case .notDetermined:
            print("Определение локации не запрошено")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
    
    func setupNotificationCenter(object: Any? = nil) {
        notificationCenter.post(name: .sharedLocation, object: object)
    }
}
