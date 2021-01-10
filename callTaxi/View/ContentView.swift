import SwiftUI
import Combine

struct ContentView : View {

    private var who:String?
    private let ud=UserDefaults.standard
    private var name:String
    private var phone:String
    
    init(who:String?) {
        self.who=who
        self.name=ud.string(forKey: DRIVER_NAME) ?? "unkown"
        self.phone=ud.string(forKey: DRIVER_PHONE) ?? "unknown"
        print("cv init")
    }
    
    var body: some View {
        switch who {
        case nil:  ModeSelectView()
        case PASSENGER: PassengerView()
        default: DriverView(name:name,phone:phone)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(who: nil)
    }
}
