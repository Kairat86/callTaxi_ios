import SwiftUI
import CoreLocation

struct ModeSelectView: View {
    @ObservedObject private var uiState = ModeSelectViewStateModel()
    let us: UserDefaults = UserDefaults.standard

    @State private var name=""
    @State private var phone=""
    @State private var valid=true
    let lm=try! LocationManager()
    
    init() {
        lm.askInUsePermission(onDenied:onDenied)
    }
    
    func onDenied()  {
        print("test")
    }
    
    var body: some View {
        switch uiState.state {
        case .passenger:PassengerView().edgesIgnoringSafeArea(.top)
        case .driver:DriverView(name:us.string(forKey: DRIVER_NAME) ?? name,
                              phone:us.string(forKey: DRIVER_PHONE) ??  phone)
        case .select: NavigationView{
            VStack(alignment: .leading){
                Text("Select app usage mode.").font(.title)
                Text("You are a:").font(.title)
                HStack{
                    Button(action: {setState(.passenger)}) {
                        Image(systemName:(uiState.state == .passenger) ? "checkmark.square":"square") .foregroundColor(colorPrimary)
                    }.font(.title)
                    Text("Passenger").font(.title)
                }.padding(.top)
                HStack{
                    Button(action: {setState(.driver)}) {
                        Image(systemName: (uiState.state == .driver) ? "checkmark.square":"square") .foregroundColor(colorPrimary)
                    }.font(.title)
                    Text("Driver").font(.title)
                }.padding(.top)
                if(uiState.state == .driver) {TextFields(name: $name, phone: $phone,valid: valid).padding(EdgeInsets(top:0,leading:15,bottom:0,trailing:15))}
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let isNameEmpty: Bool = name.isEmpty
                        let isPhoneEmpty: Bool = phone.isEmpty
                        print("name=>\(name)")
                        print("phone=>\(phone)")
                        if uiState.state == .driver && (isNameEmpty || isPhoneEmpty){
                            valid=false
                        }else{
                            print("else")
                            if uiState.state == .passenger {
                                us.set(PASSENGER,forKey: WHO)
                            }else{
                                us.set(DRIVER, forKey: WHO)
                                us.set(name, forKey: DRIVER_NAME)
                                us.set(phone,forKey: DRIVER_PHONE)
                            }
                        }
                    }, label: {
                        Text("  START  ").foregroundColor(colorYellow)
                    }).padding(.all).background(colorPrimary).cornerRadius(6.0).shadow(radius: 10)
                    Spacer()
                }
            }.padding().navigationBarTitleDisplayMode(.inline).toolbar{
                ToolbarItem(placement: .principal){
                    Text("callTaxi").font(.title).foregroundColor(colorYellow)
                }
        }
        }
        
        }
        
    }
    private func setState(_ state:ModeSelectViewStateModel.State){
            uiState.state=state
    }
}
struct TextFields:View {
    
    private var name:Binding<String>
    private var phone:Binding<String>
    private var valid:Bool=true
    
    init( name: Binding<String>, phone: Binding<String>, valid:Bool) {
        self.name=name
        self.phone=phone
        self.valid=valid
    }
    var body: some View{
        TextField("Your name", text: name).font(.title).padding().overlay(VStack{Divider().background(colorPrimary).offset(x: 0, y: 20)}).accentColor(colorPrimary)
        (!valid && name.wrappedValue.isEmpty) ? Text("Please enter your name").font(.caption).padding(.vertical,-6).foregroundColor(colorPrimary):nil
        TextField("You phone", text: phone).font(.title).padding().overlay(VStack{Divider().background(colorPrimary).offset(x: 0, y: 20)}).accentColor(colorPrimary).keyboardType(.phonePad)
        (!valid && phone.wrappedValue.isEmpty) ? Text("Please enter your phone").font(.caption).padding(.vertical,-6).foregroundColor(colorPrimary):nil
    }
}


struct AppModeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ModeSelectView()
        }
    }
}
