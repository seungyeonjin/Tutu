import SwiftUI

struct TodayScheduleView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest var today: FetchedResults<DaySchedule>
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("Today")
        }
    }
    
    init() {
        
        let startOfDate = Calendar.current.startOfDay(for: Date())
        let endOfDate = Calendar.current.date(byAdding: .day, value: 1, to: startOfDate)!
        
        let fromPredicate = NSPredicate(format: "date >= %@", startOfDate as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", endOfDate as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        _today = FetchRequest<DaySchedule>(sortDescriptors: [], predicate: datePredicate)
    }
}

struct TodayScheduleView_Previews: PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        TodayScheduleView()
    }
}
