import SwiftUI

struct TodayScheduleView: View {
    
    
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Lesson.date, ascending: true)], animation: .default)
    private var lessons: FetchedResults<Lesson>
    
    var today: Date
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("Today")
        }
    }
}

struct TodayScheduleView_Previews: PreviewProvider {
    static let dateHolder = DateHolder()
    static var previews: some View {
        TodayScheduleView(today: dateHolder.date)
    }
}
