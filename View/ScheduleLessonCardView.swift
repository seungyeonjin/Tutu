import SwiftUI

struct ScheduleLessonCardView: View {
    
    // var isFinished = false
    var lesson: Lesson
    
    var body: some View {
        ZStack {
            Color.gray
                .brightness(0.4)
            VStack {
                Text("\(lesson.title ?? "Title")")
                    .font(.footnote)
                let studentArray = lesson.students?.allObjects as! [Student]
                ForEach(studentArray) { student in
                    Text("\(student.name ?? "")")
                }
            }
            .border(Color.black, width: 2)
        }
        
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
