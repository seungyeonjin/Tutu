import SwiftUI

struct ScheduleLessonCardView: View {
    
    // var isFinished = false
    var lesson: LessonViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(lesson.color, strokeColor: Color.black)
            VStack(alignment: .leading) {
                Text("\(lesson.content)")
            }
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
