import SwiftUI

struct ScheduleLessonCardView: View {
    
    // var isFinished = false
    @ObservedObject var lessonVM: LessonListViewModel
    let lessonID: UUID
    
    var body: some View {
        ZStack {
            if let lesson = lessonVM.lessonOfId(lessonID: lessonID) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(lesson.color, strokeColor: Color.black)
                VStack(alignment: .leading) {
                    HStack() {
                        Text(lesson.title)
                            .font(.myCustomFont(size: 15))
                        Spacer()
                    }
                }
                .padding()
            }
            else { Text("") }
        }
        .border(.black)
        
    }
    
}
