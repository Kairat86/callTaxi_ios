import Foundation

class StateModel: ObservableObject  {
    
    @Published var state = State.undefined
    
    enum State:Equatable {
       
        
        case detected
        case denied
        case undefined
        case profile
        case err(Error?)
        
        static func == (lhs: StateModel.State, rhs: StateModel.State) -> Bool {
            switch (lhs,rhs) {
            case (detected,detected):return true
            case(denied,denied):return true
            case(profile,profile):return true
            case(err( _),err( _)):return true
            default:return false
            }
        }
    }
}
