import Foundation
import SwiftUI


class DateViewModel {
    
    func monthStruct(startingSpaces: Int, daysInPrevMonth: Int, count: Int, daysInMonth: Int) -> MonthStruct {
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
    
    
    
    func month(monthStruct: MonthStruct, currentMonth: Int) -> Int {
        let monthType = monthStruct.monthType
        switch monthType {
        case .Previous:
            return currentMonth - 1
        case .Next:
            return currentMonth + 1
        case .Current:
            return currentMonth
        }
    }
    
    func textColor(type: MonthType) -> Color {
        return type == MonthType.Current ? Color("daysOfMonthColor") : Color.gray
    }
    
}


struct MonthStruct {
    var monthType: MonthType
    var dayInt: Int
    func day() -> String {
        return String(dayInt)
    }
}

enum MonthType {
    case Previous
    case Current
    case Next
}


