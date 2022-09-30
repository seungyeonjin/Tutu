import SwiftUI

struct TodayScheduleView: View {
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var vm: LessonListViewModel
    
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
                    .font(.myCustomFont(size: 18))
                LessonListView(year: year, month: month, day: day, vm: vm)
                    .padding()
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
