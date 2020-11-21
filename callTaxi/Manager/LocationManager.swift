import CoreLocation
import SwiftUI

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var delegate:LocationDelegate?
       // - API
       public var exposedLocation: CLLocation? {
           return self.locationManager.location
       }

    override init() {
           super.init()
           self.locationManager.delegate = self
           self.locationManager.desiredAccuracy =  kCLLocationAccuracyBest
           self.locationManager.requestAlwaysAuthorization()
           self.locationManager.pausesLocationUpdatesAutomatically=false
           self.locationManager.allowsBackgroundLocationUpdates=true
           self.locationManager.requestLocation()
       }
    
    func  locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       print("loc update=>\(locations)")
        delegate?.onDetected()
        DispatchQueue.main.asyncAfter(deadline: .now() + 19, execute: {
            self.locationManager.requestLocation()
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("err=>\(error)")
    }
}
