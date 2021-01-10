import SwiftUI

struct PassengerView: View {
    @ObservedObject private var uiState = PassengerViewStateModel()
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor=UIColor(red: 0.53, green: 0.07, blue: 0.27, alpha: 1.00)
        
    }
    
    var body: some View {
        switch uiState.state {
        case .fetched(let taxists):
                TabView{
                    ListView(taxists: taxists).tabItem{Text("Drivers").font(.system(size:40))}
                    MapView(taxists: testArr).tabItem{Text("On map").font(.system(size:40))}.edgesIgnoringSafeArea(.top)
                }.accentColor(colorYellow)
        default:
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: colorPrimary)).scaleEffect(1.5, anchor: .center)
        }
    }
}

struct PassengerView_Previews: PreviewProvider {
    static var previews: some View {
        PassengerView()
    }
}
