//
// Filename: UserLocationService.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import Combine
import CoreLocation

protocol UserLocationService {
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestAuthorization()

    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void)
    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void)
}

final class ProductionUserLocationService: NSObject, UserLocationService {

    private let manager: CLLocationManager
    private var stateChangeHandler: ((CLAuthorizationStatus) -> Void)?
    private var locationChangeHandler: (([CLLocation]) -> Void)?

    override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
    }

    func requestAuthorization() {
        let authorizationStatus = manager.authorizationStatus

        if authorizationStatus == .denied || authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }

    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void) {
        self.locationChangeHandler = handler
    }

    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }

    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }

    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void) {
        self.stateChangeHandler = handler
    }
}

extension ProductionUserLocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.stateChangeHandler?(manager.authorizationStatus)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationChangeHandler?(locations)
    }
}

final class MockLocationService: UserLocationService {
    func startUpdatingLocation() { /* nop */ }
    func stopUpdatingLocation() { /* nop */ }
    func listenDidUpdateLocation(handler: @escaping ([CLLocation]) -> Void) { /* nop */ }
    func requestAuthorization() { /* nop */ }
    func listenDidUpdateStatus(handler: @escaping (CLAuthorizationStatus) -> Void) { /* nop */ }
}
