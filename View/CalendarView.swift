import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    @State private var isShowingAddSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    Button(action: previousMonth) {
                        Image(systemName: "arrow.left")
                    }
                    Text(CalendarHelper().monthYearString(dateHolder.date))
                        .font(.title2)
                    Button(action: nextMonth) {
                        Image(systemName: "arrow.right")
                    }
                    Spacer()
                }
                dayOfWeekStack
                calendarGrid
            } //: VSTACK
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingAddSheet = true }) {
                        Label("Add Lesson", systemImage: "plus")
                    }
                    .sheet(isPresented: $isShowingAddSheet) {
                        AddLessonView()
                    }
                }
            }
        }
    }
    
    var dayOfWeekStack: some View {
        HStack(spacing: 1) {
            Text("Sun").dayOfWeek()
            Text("Mon").dayOfWeek()
            Text("Tue").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thu").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
        }
    }
    
    var calendarGrid: some View {
        
        VStack(spacing: 1) {
            
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            let currentMonth = CalendarHelper().currentMonth(dateHolder.date)
            let currentYear = CalendarHelper().currentYear(dateHolder.date)
            
            ForEach(0..<6) { row in
                HStack(spacing: 1) {
                    ForEach(1..<8) { column in
                        let count = column + (row * 7)
                        CalendarCell(count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth, month: currentMonth, year: currentYear)
                            .environmentObject(dateHolder)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
    }
    
    func previousMonth() {
        dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
    }
    
    func nextMonth() {
        dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
        
    }
    
}

struct Calendar_Previews: PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        CalendarView()
            .environmentObject(dateHolder)
            .previewLayout(.sizeThatFits)
    }
}

extension Text {
    func dayOfWeek() -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}
