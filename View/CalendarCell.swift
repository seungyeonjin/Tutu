import SwiftUI

struct CalendarCell: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    let count: Int
    let startingSpaces: Int
    let daysInMonth : Int
    let daysInPrevMonth: Int
    let month: Int
    let year: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(monthStruct().day())
                .foregroundColor(textColor(type: monthStruct().monthType))
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(1)
            InsetCalendarCellView(year: year, month: month, day: monthStruct().dayInt)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            Spacer()
        }
        .padding(5)
        .frame(width: 50, height: 85)
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
        CalendarCell(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMonth: 1, month: 1, year: 1998)
            .environmentObject(dateHolder)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
