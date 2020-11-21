//
//  ListView.swift
//  callTaxi
//
//  Created by Kairat Doshekenov on 10/23/20.
//

import SwiftUI

struct ListView: View {
    
    var taxists:[Taxist]
    
    var body: some View {
        List(taxists, id: \.phone){taxist in
            TaxistView(taxist: taxist)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(taxists: testArr)
    }
}
