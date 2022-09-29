import SwiftUI

struct InsetCalendarCellView: View {
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    let lemonYellow = Color(hue: 0.16, saturation: 0.4, brightness: 1)
    
    var year: Int
    var month: Int
    var day: Int
    @ObservedObject var lessonListVM: LessonListViewModel
    
    init(year: Int, month: Int, day: Int, vm: LessonListViewModel) {
        self.year = year
        self.month = month
        self.day = day
        self.lessonListVM = vm
    }
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 2) {
                ForEach(lessonListVM.lessonsOnDate(year: year, month: month, day: day), id: \.id) { lesson in
                    ZStack {
                        Text("\(lesson.title)")
                            .lineLimit(1)
                            .font(.caption2)
                            .padding(2)
                            .frame(alignment: .leading)
                            .background(lesson.color)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.black, lineWidth: 1))
                    }
                    
                }
            }
            .padding(3)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
    
}

