import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            if !viewModel.signedIn {
                SignInView()
                    .environmentObject(viewModel)
                    
            } else {
                let dateHolder = DateHolder()
                HomeView()
                    .environmentObject(dateHolder)
                    .environment(\.managedObjectContext, viewContext)
                }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
