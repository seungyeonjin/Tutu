import SwiftUI

struct InsetCalendarCellView: View {
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest private var lessons: FetchedResults<Lesson>
    
    var body: some View {
        
        ForEach(lessons) { lesson in
            HStack {
                Image(systemName: "octagon")
                VStack {
                    Text("\(lesson.title ?? "Title")")
                        .font(.footnote)
                }
            }
        }
    }
    
    init(year: Int, month: Int, day: Int) {
        let startOfDate = Date.from(year: year, month: month, day: day)!
        let endOfDate = Calendar.current.date(byAdding: .day, value: 1, to: startOfDate)!
        
        let startPredicate1 = NSPredicate(format: "startDate >= %@", startOfDate as NSDate)
        let startPredicate2 = NSPredicate(format: "startDate < %@", endOfDate as NSDate)
        let startPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [startPredicate1, startPredicate2])
        
        let endPredicate1 = NSPredicate(format: "endDate >= %@", startOfDate as NSDate)
        let endPredicate2 = NSPredicate(format: "endDate < %@", endOfDate as NSDate)
        let endPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [endPredicate1, endPredicate2])
        
        let datePredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [startPredicate, endPredicate])
        
        _lessons = FetchRequest<Lesson>(sortDescriptors: [], predicate: datePredicate)
    }
}
/*
struct InsetCalendarCellView_Previews:
    PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        InsetCalendarCellView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
 */
