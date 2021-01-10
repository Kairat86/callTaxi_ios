import Foundation
import SwiftUI

let STOPPED = "stopped"
let WHO = "who"
let DRIVER_NAME = "driver_name"
let DRIVER_PHONE = "driver_phone"
let PASSENGER = "passenger"
let DRIVER="driver"
let testTaxist=Taxist(name: "1", phone: "2", lat: 3, lon: 4)
let testArr=[testTaxist]
let colorYellow=Color(hex: "F3FF1A")
let colorPrimary=Color(hex: "871144")

func readPropertyList() throws -> [String:AnyObject]{
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        let plistPath: String? = Bundle.main.path(forResource: "local", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
            return try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String : AnyObject]
    }
