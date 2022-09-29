import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            
            
            
            
            Button(action: {
                viewModel.signout()
            }, label: {
                Text("Sign Out")
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
