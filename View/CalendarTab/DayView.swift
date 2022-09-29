import SwiftUI

struct DayView: View {
    
    let year: Int
    let month: Int
    let day: Int
    
    @ObservedObject var vm: LessonListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(vm.lessonsOnDate(year: year, month: month, day: day), id: \.id) { lesson in
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
        }
    }
}
