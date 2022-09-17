import SwiftUI

struct ScheduleLessonCardView: View {
    
    var isFinished = false
    
    var body: some View {
        if isFinished {
            Color.gray
        } else { Color.indigo }
    }
}

struct ScheduleLessonCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleLessonCardView(isFinished: true)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
