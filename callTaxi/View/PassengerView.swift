//
//  PassengerView.swift
//  callTaxi
//
//  Created by Kairat Doshekenov on 11/1/20.
//

import SwiftUI

struct PassengerView: View {
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor=UIColor(red: 0.53, green: 0.07, blue: 0.27, alpha: 1.00)
    }
    var body: some View {
        TabView{
            ListView(taxists: testArr).tabItem{Text("Drivers").font(.system(size:40))}
            MapView(taxists: testArr).tabItem{Text("On map").font(.system(size:40))}.edgesIgnoringSafeArea(.top)
        }.accentColor(colorYellow).edgesIgnoringSafeArea(.top)
    }
}

struct PassengerView_Previews: PreviewProvider {
    static var previews: some View {
        PassengerView()
    }
}
