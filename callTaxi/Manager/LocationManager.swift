import CoreLocation
import SwiftUI

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var stopped=false
    var delegate:LocationDelegate?
    private var name:String
    private var phone:String
    var taxist:Taxist? = nil
    private var request:URLRequest
    private var url:URL!
    private var onAuthorized:(()->Void)?
    private var onDenied:(()->Void)?

     init(_ name:String="", _ phone:String="") throws {
        print("lm init name=>\(name)")
        print("lm init phone=>\(phone)")
        self.name=name
        self.phone=phone
        let map: [String : AnyObject] = try readPropertyList()
        url=URL(string:map["server_debug"] as! String)
        request=URLRequest(url: url)
        request.httpMethod="POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy =  kCLLocationAccuracyBest
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization status=>\(manager.authorizationStatus.rawValue)")
        manager.pausesLocationUpdatesAutomatically=false
        manager.allowsBackgroundLocationUpdates=true
        if manager.authorizationStatus == .authorizedAlways{
            delegate?.authorizedAways(manager)
        } else if manager.authorizationStatus == .authorizedWhenInUse{
            (onAuthorized ?? {print("on auth not def")})()
        }else if manager.authorizationStatus == .denied{
            (onDenied ?? {print("denied not defined")})()
        }
    }
    
    func  locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        sendLcationToServer(coords: locations[0].coordinate)
    }
    
    func sendLcationToServer(coords: CLLocationCoordinate2D)  {
        if taxist==nil {
            print("taxist is nil")
            taxist=Taxist(name: name, phone: phone, lat: coords.latitude, lon: coords.longitude)
            let data: Data = try! JSONEncoder().encode(taxist)
            request.httpBody=data
            request.url=url.appendingPathComponent("/send")
        }else{
            request.httpBody="\(phone):\(coords.latitude):\(coords.longitude)".data(using: String.Encoding.utf8)
            request.url=url.appendingPathComponent("/send-coords")
        }
        URLSession.shared.dataTask(with: request) {
                    data, response, error in
                        DispatchQueue.main.sync {[weak self]  in
                            if error != nil{
                                self?.delegate!.onError(error)
                            }else{
                                self?.delegate?.onDetected()
                            }
                        }
            }.resume()
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("err=>\(error)")
    }
    func stop() {
        update(name, phone)
        locationManager.stopUpdatingLocation()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    func update(_ name:String, _ phone:String)  {
        request.httpBody=self.phone.data(using: String.Encoding.utf8)
        request.url=url.appendingPathComponent("/remove")
        URLSession.shared.dataTask(with: request) {
                    data, response, error in
                        DispatchQueue.main.sync {[weak self]  in
                            if error != nil{
                                self?.delegate!.onError(error)
                            }
                        }
            }.resume()
        self.name=name
        self.phone=phone
        taxist=nil
    }
    
    func askInUsePermission(onDenied:@escaping()->Void)  {
        self.onDenied=onDenied
        locationManager.requestWhenInUseAuthorization()
    }
}
