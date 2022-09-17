import SwiftUI

struct InsetCalendarCellView: View {
    
    let date: Date
    
    
    var dayOfMonth { calendar.dateComponents([.day], from: date)
    }
    let
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DaySchedule.date, ascending: true)],
        animation: .default)
    private var daySchedule: FetchedResults<DaySchedule>
    
    var body: some View {
        HStack {
            
        }
    }
}

struct InsetCalendarCellView_Previews:
    PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        InsetCalendarCellView(date: dateHolder.date)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
