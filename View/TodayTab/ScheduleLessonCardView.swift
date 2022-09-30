import SwiftUI

struct ScheduleLessonCardView: View {
    
    // var isFinished = false
    @ObservedObject var lessonVM: LessonListViewModel
    let lessonID: UUID
    let lesson: LessonViewModel
    
    init(lessonVM: LessonListViewModel, lessonID: UUID) {
        self.lessonVM = lessonVM
        self.lessonID = lessonID
        lesson = lessonVM.lessonOfId(lessonID: lessonID)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(lesson.color, strokeColor: Color.black)
            VStack(alignment: .leading) {
                Text("\(lesson.content)")
            }
        }
        .border(.black)
        .padding()
        
    }
    
}

/*
struct ScheduleLessonCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleLessonCardView(isFinished: true)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
*/
