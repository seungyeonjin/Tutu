import SwiftUI

struct LessonListView: View {
    
    var year: Int
    var month: Int
    var day: Int
    
    @ObservedObject var vm: LessonListViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.lessonsOnDate(year: year, month: month, day: day), id: \.id) { lesson in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(lesson.student.name)")
                                .font(.myCustomFont(size: 16))
                                .cornerRadius(4)
                                .border(.black)
                                .background(lesson.color)
                            Text("\(lesson.title)")
                                .font(.myCustomFont(size: 12))
                                .foregroundColor(.gray)
                        }
                        ScheduleLessonCardView(lesson: lesson)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.myCustomFont(size: 20))
                      .foregroundColor(Color.black)
                }
            }
        }
    }
}
