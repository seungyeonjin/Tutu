import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            TodayScheduleView(today: dateHolder.date)
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Image(systemName: "house")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                }
                .environmentObject(dateHolder)
            
            ClassroomView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Image(systemName: "studentdesk")
                }
            NavigationView {
                NavigationLink("Navigate") {
                    
                }
            }
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        ContentView()
            .environmentObject(dateHolder)
    }
}
