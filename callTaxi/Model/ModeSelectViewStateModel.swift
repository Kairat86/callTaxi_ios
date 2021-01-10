//
//  ModeSelectViewStateModel.swift
//  callTaxi
//
//  Created by Kairat Doshekenov on 1/5/21.
//

import Foundation

class ModeSelectViewStateModel: ObservableObject {
    @Published var state = State.select
    
    enum State{
       case select, passenger, driver
    }
}
