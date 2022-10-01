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
                    Text("\(lesson.content)")
                }
            }
            else { Text("") }
        }
        .border(.black)
        
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
