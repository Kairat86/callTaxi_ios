import SwiftUI
import CoreLocation

struct DriverView: View, LocationDelegate {
    
    
    @ObservedObject private var model = StateModel()
    private  var locationManager:LocationManager!
    @State private var stopped=false
    let us: UserDefaults = UserDefaults.standard
    private var name:Binding<String>
    private var phone:Binding<String>
    @State private var valid=true
    @State private var previousState:StateModel.State = .undefined
    
    init(name:String,phone:String) {
        print("name=>\(name)")
        var n=name
        var p=phone
        self.name = Binding(get:{n}, set: {newValue in n=newValue})
        self.phone = Binding(get:{p},set:{nv in p=nv})
        print("self.name=>\(self.name.wrappedValue)")
        locationManager = try! LocationManager(name,phone)
        locationManager.delegate=self
    }
    
    
    
    func onDetected() {
        if model.state != .detected && model.state != .profile {
            model.state = .detected
        }
    }
    
    func onDenied()  {
        model.state = .denied
    }
    
    func onError(_ error: Error?) {
        locationManager.stop()
        model.state = .err(error)
    }
    
    func authorizedAways(_ manager: CLLocationManager) {
        manager.startUpdatingLocation()
    }
    
    var body: some View {
        switch model.state {
        case .detected:
            NavigationView{
             VStack {
                Text(stopped ? "Having a rest" : "Wating for order calls...").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding().shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Text(stopped ? "(App is not sending your location to server anymore)":"(App is sending your location to server each 20 seconds)").font(.caption).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Button(action: {
                    stopped ? locationManager.start() : locationManager.stop()
                    stopped.toggle()
                    UserDefaults.standard.set(stopped, forKey: STOPPED)
                }, label: {
                    Text(stopped ? "START!" :"Have a rest").foregroundColor(colorYellow)
                }).padding(.all).background(colorPrimary).cornerRadius(6.0).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .top).navigationBarTitleDisplayMode(.inline).toolbar{
                        ToolbarItem(placement: .principal){
                            Text("callTaxi").font(.title).foregroundColor(colorYellow)
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Image(systemName: "person.fill").foregroundColor(colorYellow).padding().onTapGesture {
                                previousState=model.state
                                model.state = .profile
                            }
                        }
                    }
            }
        case .profile:NavigationView {
            VStack{
            TextField("Your name", text: name).font(.title).padding().overlay(VStack{Divider().background(colorPrimary).offset(x: 0, y: 20)}).accentColor(colorPrimary)
           !valid && name.wrappedValue.isEmpty ? Text("Please enter your name").font(.caption).padding(.vertical,-6).foregroundColor(colorPrimary):nil
            TextField("You phone", text: phone).font(.title).padding().overlay(VStack{Divider().background(colorPrimary).offset(x: 0, y: 20)}).accentColor(colorPrimary).keyboardType(.phonePad)
            !valid && phone.wrappedValue.isEmpty ? Text("Please enter your phone").font(.caption).padding(.vertical,-6).foregroundColor(colorPrimary):nil
                Spacer()
                Button(action: {
                    if name.wrappedValue.isEmpty || phone.wrappedValue.isEmpty {
                        valid=false
                    } else {
                        let sameName: Bool = us.string(forKey: DRIVER_NAME) == name.wrappedValue
                        let samePhone: Bool = us.string(forKey: DRIVER_PHONE) == phone.wrappedValue

                        if !sameName {
                        us.set(name.wrappedValue, forKey: DRIVER_NAME)
                        }
                        if !samePhone {
                        us.set(phone.wrappedValue,forKey: DRIVER_PHONE)
                        }
                        if !sameName || !samePhone {
                        locationManager.update(name.wrappedValue,phone.wrappedValue)
                        }
                        model.state=previousState
                    }
                }, label: {
                    Text("Save").foregroundColor(colorYellow)
                }).padding(.all).background(colorPrimary).cornerRadius(6.0).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }.padding().navigationBarTitleDisplayMode(.inline).toolbar{
                ToolbarItem(placement: .principal){
                    Text("callTaxi").font(.title).foregroundColor(colorYellow)
                }
        }
        }
        case .denied:NavigationView{
            VStack {
               Text("Sorry but you can't use this app without location permission granted. In order to use this app go to 'Location Services' settings and grant permission to callTaxi").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding().shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
               Button(action: {
                if let bundleId = Bundle.main.bundleIdentifier,
                    let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
                {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
               }, label: {
                   Text("Open settings").foregroundColor(colorYellow)
               }).padding(.all).background(colorPrimary).cornerRadius(6.0).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
           }.frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity,
                   alignment: .top).navigationBarTitleDisplayMode(.inline).toolbar{
                       ToolbarItem(placement: .principal){
                           Text("callTaxi").font(.title).foregroundColor(colorYellow)
                       }
                   }
           }
        case .err(let e):
            NavigationView{
            VStack{
                Text("Error: \(e?.localizedDescription ?? "Unkown error")").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding().shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action: {
                    locationManager.taxist=nil
                    locationManager.start()
                    model.state = .undefined
                }, label: {
                    Text("Try again ").foregroundColor(colorYellow)
                }).padding(.all).background(colorPrimary).cornerRadius(6.0).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .top).navigationBarTitleDisplayMode(.inline).toolbar{
                        ToolbarItem(placement: .principal){
                            Text("callTaxi").font(.title).foregroundColor(colorYellow)
                        }
                    }
            }
        
        default:
           ProgressView().progressViewStyle(CircularProgressViewStyle(tint: colorPrimary)).scaleEffect(1.5, anchor: .center)
        }
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView(name:"name", phone:"phone")
    }
}
