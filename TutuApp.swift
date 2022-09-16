import SwiftUI

@main
struct TutuApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            let dateHolder = DateHolder()
            ContentView()
                .environmentObject(dateHolder)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
