import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) private var viewContext

    @State private var isShowingAddSheet: Bool = false
    
    let salmon = Color(hue: 0.02, saturation: 0.4, brightness: 1)
    
    @ObservedObject var vm: LessonListViewModel
    var dateVM = DateViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack() {
                    HStack {
                        Spacer()
                        Button(action: previousMonth) {
                            ZStack {
                                Image(systemName: "arrowtriangle.left.fill")
                                    .foregroundColor(salmon)
                                    .font(.system(size: 15))
                                Image(systemName: "arrowtriangle.left")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 15, weight: .light))

                            }
                        }
                        Text(CalendarHelper().monthYearString(dateHolder.date))
                            .font(.myCustomFont(size: 15))
                        Button(action: nextMonth) {
                            ZStack {
                                Image(systemName: "arrowtriangle.right.fill")
                                    .foregroundColor(salmon)
                                    .font(.system(size: 15))
                                Image(systemName: "arrowtriangle.right")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 15, weight: .light))

                            }
                        }
                        Spacer()
                    }
                    dayOfWeekStack
                    calendarGrid(geometry.size)
                        .padding(3)
                } //: VSTACK
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                            Text("Monthly Schedule")
                                .font(.system(size: 20, design: .serif))
                              .foregroundColor(Color.black)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { isShowingAddSheet = true }
                            , label: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color.gray.opacity(0.2))
                                    .font(.system(size: 15))
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(Color.black)
                            }
                        })
                        .sheet(isPresented: $isShowingAddSheet) {
                            AddLessonView(vm: vm, studentVM: StudentListViewModel(context: viewContext))
                        }
                    }
                }
            }
        }
    }
    
    var dayOfWeekStack: some View {
        HStack() {
            let dayOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            ForEach(dayOfWeek, id: \.self) { day in
                Text(day)
                    .font(.myCustomFont(size: 12))
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .padding(1)
            }
        }
    }
    
    func calendarGrid(_ screenSize: CGSize) -> some View {
        
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
                        let monthStruct = dateVM.monthStruct(startingSpaces: startingSpaces, daysInPrevMonth: daysInPrevMonth, count: count, daysInMonth: daysInMonth)
                        let month = dateVM.month(monthStruct: monthStruct, currentMonth: currentMonth)
                        let textColor = dateVM.textColor(type: monthStruct.monthType)
                        NavigationLink(destination: DayView(year: currentYear, month: month, day: monthStruct.dayInt, vm: vm)) {
                            CalendarCell(year: currentYear, month: month, day: monthStruct.dayInt, textColor: textColor, vm: vm)
                                .environmentObject(dateHolder)
                                .frame(maxWidth: abs(screenSize.width-6)/7, maxHeight: abs(screenSize.height-15)/7)
                                .border(.black)
                                .foregroundColor(.black)
                        }
                        
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

