import CoreLocation
import Foundation

struct Taxist {
    var name:String
    var phone:String
    var lat:Double
    var lon:Double

    var locationCoordinate: CLLocationCoordinate2D {
           CLLocationCoordinate2D(
               latitude: lat,
               longitude: lon)
       }
}
