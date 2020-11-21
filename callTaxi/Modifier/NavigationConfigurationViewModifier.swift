import SwiftUI

struct NavigationConfigurationViewModifier: ViewModifier {

     let configure: (UINavigationBar) -> ()

     func body(content: Content) -> some View {
         content.background(NavigationConfigurator(configure: {
             configure($0.navigationBar)
         }))
     }
 }
