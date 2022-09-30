import Foundation
import SwiftUI

class CalendarHelper {
    var calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func hm(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func hms(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func dayMonthYearString(_ date: Date) -> String {
        dateFormatter.dateFormat = "LLLL dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func monthYearString(_ date: Date) -> String {
        dateFormatter.dateFormat = "MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func plusMonth(_ date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(_ date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func daysInMonth(_ date: Date) -> Int {
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        // returns the days in a given month
        
        return range.count
    }
    
    func dayOfMonth(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        // returns the day component from date
        // ex) april 29th -> 29
        return components.day!
    }
    
    func currentMonth(_ date: Date) -> Int {
        let components = calendar.dateComponents([.month], from: date)
        return components.month!
    }
    
    func currentYear(_ date: Date) -> Int {
        let components = calendar.dateComponents([.year], from: date)
        return components.year!
    }
    
    func firstOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(_ date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday!-1
    }

}
