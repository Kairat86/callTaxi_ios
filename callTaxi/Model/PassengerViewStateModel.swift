import Foundation

class PassengerViewStateModel: ObservableObject {
    
    @Published var state = State.undefined
    
    enum State:Equatable {
        case fetched([Taxist])
        case undefined
        case err(Error?)
        
    static func == (lhs: PassengerViewStateModel.State, rhs: PassengerViewStateModel.State) -> Bool {
            switch (lhs,rhs) {
            case (fetched( _),fetched( _)):return true
            case(err( _),err( _)):return true
            default:return false
            }
        }
    }
}
