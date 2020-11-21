import SwiftUI
import Combine

struct ContentView : View {

    private var who:String?
    
    init(who:String?) {
        self.who=who
        
        
    }
    
    var body: some View {
        switch who {
        case nil:  ModeSelectView()
        case PASSENGER: ListView(taxists: testArr)
        default: DriverView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(who: nil)
    }
}
