import SwiftUI

struct TodayScheduleView: View {
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    var cal = CalendarHelper()
    var date = Date()
    
    var day: Int {
        cal.dayOfMonth(date)
    }
    
    var year: Int {
        cal.currentYear(date)
    }
    
    var month: Int {
        cal.currentMonth(date)
    }
    
    var dateString: String {
        cal.dayMonthYearString(date)
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(dateString)")
                LessonListView(year: year, month: month, day: day, vm: LessonListViewModel(context: viewContext))
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                        Text("Home")
                            .font(.system(size: 20, design: .serif))
                          .foregroundColor(Color.black)
                }
            }
        }
    }
}

struct TodayScheduleView_Previews: PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        TodayScheduleView()
    }
}
