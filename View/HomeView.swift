
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        let studentVM = StudentListViewModel(context: viewContext)
        let lessonVM = LessonListViewModel(context: viewContext)
        
        TabView {
            TodayScheduleView(vm: lessonVM)
                .environmentObject(dateHolder)
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    Image(systemName: "house")
                }
            CalendarView(vm: lessonVM)
                .tabItem {
                    Image(systemName: "calendar")
                }
                .environmentObject(dateHolder)
                .environment(\.managedObjectContext, viewContext)
            
            ClassroomView(studentVM: studentVM)
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
