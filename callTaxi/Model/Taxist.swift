import CoreLocation
import Foundation
import SwiftUI

class Taxist:ObservableObject , Encodable{
    var name:String
    var phone:String
    var lat:Double
    var lon:Double

    init(name:String, phone:String, lat:Double, lon:Double) {
        self.name=name
        self.phone=phone
        self.lat=lat
        self.lon=lon
    }
    
    var locationCoordinate: CLLocationCoordinate2D {
           CLLocationCoordinate2D(
               latitude: lat,
               longitude: lon)
       }
}
