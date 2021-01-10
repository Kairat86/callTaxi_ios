//
//  LocationDelegate.swift
//  callTaxi
//
//  Created by Kairat Doshekenov on 11/17/20.
//

import Foundation
import CoreLocation

protocol LocationDelegate {
    func onDetected()
    func onDenied()
    func onError(_ error:Error?)
    func authorizedAways(_ manager:CLLocationManager)
}
