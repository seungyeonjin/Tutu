
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            TodayScheduleView()
                .environmentObject(dateHolder)
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

struct HomeView_Previews: PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        HomeView()
            .environmentObject(dateHolder)
    }
}
