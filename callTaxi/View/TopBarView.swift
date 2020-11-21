//
//  TopBarView.swift
//  callTaxi
//
//  Created by Kairat Doshekenov on 10/28/20.
//

import SwiftUI

struct TopBarView:View {
    var body:some View{
        VStack(spacing: 20){
            Spacer().frame(height: 20)
            HStack{
                Text("callTaxi").font(.system(size: 20)).fontWeight(.semibold).foregroundColor(colorYellow)
                Spacer()
            }
        }.padding().background(colorPrimary).edgesIgnoringSafeArea(.top)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
