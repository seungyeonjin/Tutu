import SwiftUI

struct DayLessonCardView: View {

    
    @ObservedObject var vm: LessonListViewModel
    var lesson: LessonViewModel
    
    let cal = CalendarHelper()
    
    init(lessonVM: LessonListViewModel, lessonID: UUID) {

        self.vm = lessonVM
        self.lesson = lessonVM.lessonOfId(lessonID: lessonID)
    }
    
    var body: some View {
        HStack {
            VStack {
                let startString = cal.hm(lesson.startDate)
                Text("\(startString)")
                    .font(.myCustomFont(size: 12))
                Spacer()
                let endString = cal.hm(lesson.endDate)
                Text("\(endString)")
                    .font(.myCustomFont(size:12))
            }
            .foregroundColor(.black)
            VStack(alignment: .leading) {
                Text("\(lesson.title)")
                    .font(.caption2)
                    .foregroundColor(.black)
                    .padding(2)
                    .frame(alignment: .leading)
                Text(lesson.content)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.black)
                    .frame(maxHeight: .infinity)
                    .lineLimit(Int.max)
                    .padding()
            }
            .background(lesson.color)
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(Color.black, lineWidth: 1))
            .border(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
