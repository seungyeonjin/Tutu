import SwiftUI

struct LessonListView: View {
    
    var year: Int
    var month: Int
    var day: Int
    
    @ObservedObject var vm: LessonListViewModel
    var dayLessons: [LessonViewModel]
    
    init(year: Int, month: Int, day: Int, vm: LessonListViewModel) {
        self.year = year
        self.month = month
        self.day = day
        self.vm = vm
        self.dayLessons = vm.lessonsOnDate(year: year, month: month, day: day)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(dayLessons, id: \.id) { lesson in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(lesson.student?.name ?? "Unknown")")
                                .font(.myCustomFont(size: 16))
                                .padding(4)
                                .cornerRadius(4)
                                .border(.black)
                                .background(lesson.color)
                            Text("\(lesson.title)")
                                .font(.myCustomFont(size: 12))
                                .foregroundColor(.gray)
                        }
                        ScheduleLessonCardView(lessonVM: vm, lessonID: lesson.id)
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
