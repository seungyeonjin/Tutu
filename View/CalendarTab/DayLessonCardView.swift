import SwiftUI

struct DayLessonCardView: View {

    
    @ObservedObject var lessonVM: LessonListViewModel
    var lessonID: UUID
    
    let cal = CalendarHelper()
    
    var body: some View {
        
        if let lesson = lessonVM.lessonOfId(lessonID: lessonID) {
            HStack {
                VStack {
                    let startString = cal.hm(lesson.startDate)
                    Text("\(startString)")
                        .font(.myCustomFont(size: 12))
                        .fontWeight(.bold)
                    Spacer()
                    let endString = cal.hm(lesson.endDate)
                    Text("\(endString)")
                        .font(.myCustomFont(size:12))
                        .fontWeight(.bold)
                }
                .foregroundColor(.black)
                VStack(alignment: .leading) {
                    Text("\(lesson.title)")
                        .font(.caption2)
                        .foregroundColor(.black)
                        .padding(2)
                        .frame(alignment: .leading)
                    Text(lesson.memo)
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
        else {
            Text("")
        }
    }
}
