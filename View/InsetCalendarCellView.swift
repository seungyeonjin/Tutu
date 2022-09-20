import SwiftUI

struct InsetCalendarCellView: View {
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest private var lessons: FetchedResults<Lesson>
    
    let lemonYellow = Color(hue: 0.16, saturation: 0.4, brightness: 1)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            ForEach(lessons) { lesson in
                ZStack {
                    Text("\(lesson.title ?? "Title")")
                        .font(.caption2)
                        .padding(1)
                        .frame(alignment: .leading)
                        .background(lemonYellow)
                        .overlay(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.black, lineWidth: 1))
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

struct InsetCalendarCellView_Previews:
    PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        InsetCalendarCellView(year: 2022, month: 9, day: 20)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

