import SwiftUI

struct CalendarCell: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    let count: Int
    let startingSpaces: Int
    let daysInMonth : Int
    let daysInPrevMonth: Int
    
    var body: some View {
        VStack {
            Text(monthStruct().day())
                .foregroundColor(textColor(type: monthStruct().monthType))
            InsetCalendarCellView(date: dateHolder.date)
        }
    }
    
    func textColor(type: MonthType) -> Color {
        return type == MonthType.Current ? Color("daysOfMonthColor") : Color.gray
    }
    
    func monthStruct() -> MonthStruct {
        let start = startingSpaces == 0 ? startingSpaces+7 : startingSpaces
        if(count <= start) {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: MonthType.Previous, dayInt: day)
        } else if (count-start > daysInMonth) {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        CalendarCell(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMonth: 1)
            .environmentObject(dateHolder)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
