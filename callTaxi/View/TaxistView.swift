//
//  TaxistView.swift
//  callTaxi
//
//  Created by Kairat Doshekenov on 10/23/20.
//

import SwiftUI

struct TaxistView: View {
    
    var taxist:Taxist
    
    var body: some View {
        HStack {
            Text(taxist.name)
            Spacer()
            Text("distance")
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "video.fill").renderingMode(.template).padding()
            }).foregroundColor(colorYellow).background(colorPrimary).cornerRadius(6)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "phone.fill").renderingMode(.template).padding()
            }).foregroundColor(colorYellow).background(colorPrimary).cornerRadius(6)
        }.padding()
    }
}

struct TaxistView_Previews: PreviewProvider {
    static var previews: some View {
        TaxistView(taxist: testTaxist)
    }
}
