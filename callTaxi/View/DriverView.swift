import SwiftUI

struct DriverView: View, LocationDelegate {
    
    @ObservedObject private var detectModel = DetectModel()
    private var locationManager=LocationManager()
 
    init() {
        locationManager.delegate=self
    }
    
    func onDetected() {
        print("onDetected")
        if detectModel.detected{return}
        detectModel.detected.toggle()
    }
    var body: some View {
        switch detectModel.detected {
        case true:
             VStack {
                Text("Wating for order calls...)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding().shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Text("(App is sending your location to server each 20 seconds)").padding().shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Button(action: {
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                }, label: {
                    Text("Have a rest").foregroundColor(colorYellow)
                }).padding(.all).background(colorPrimary).cornerRadius(6.0).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .top)
        default:
           ProgressView().progressViewStyle(CircularProgressViewStyle(tint: colorPrimary)).scaleEffect(1.5, anchor: .center)
        }
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView()
    }
}
