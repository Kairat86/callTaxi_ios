import SwiftUI

struct ModeSelectView: View {
    
    @State private  var modeHolder:Bool?=nil
    @State private var isPassenger:Bool?=nil
    
    var body: some View {
        switch modeHolder {
        case true:PassengerView().edgesIgnoringSafeArea(.top)
        case false:DriverView()
        default: NavigationView{
            VStack(alignment: .leading){
            Text("Select app usage mode.").font(.title)
            Text("You are a:").font(.title)
            HStack{
                Button(action: {toggle(b: true)}) {
                    Image(systemName:(isPassenger==nil||isPassenger==false) ?"square"  : "checkmark.square" ).foregroundColor(colorPrimary)
                }.font(.title)
                Text("Passenger").font(.title)
            }.padding(.top)
            HStack{
                Button(action: {toggle(b: false)}) {
                    Image(systemName: (isPassenger==nil||isPassenger==true) ? "square"  : "checkmark.square").foregroundColor(colorPrimary)
                }.font(.title)
                Text("Driver").font(.title)
            }.padding(.top)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    modeHolder=isPassenger
                    UserDefaults.standard.set(isPassenger==true ? PASSENGER : DRIVER, forKey: WHO)
                }, label: {
                    Text("  START  ").foregroundColor(colorYellow)
                }).padding(.all).background(colorPrimary).cornerRadius(6.0).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }.padding()
            .navigationBarTitle(Text("callTaxi"),displayMode: .inline).background(NavigationConfigurator { nc in
                            nc.navigationBar.barTintColor = UIColor(colorPrimary)
                            nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(colorYellow)]
            })
        }
        
        }
        
    }
    private func toggle(b:Bool){
       isPassenger=b
    }
}

struct AppModeView_Previews: PreviewProvider {
    static var previews: some View {
        ModeSelectView()
    }
}
