
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
            CalendarView(vm: LessonListViewModel(context: viewContext))
                .tabItem {
                    Image(systemName: "calendar")
                }
                .environmentObject(dateHolder)
                .environment(\.managedObjectContext, viewContext)
            
            ClassroomView(studentVM: StudentListViewModel(context: viewContext))
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Image(systemName: "studentdesk")
                }
            ProfileView()
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
