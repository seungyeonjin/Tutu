import SwiftUI

struct LessonListView: View {
    
    var year: Int
    var month: Int
    var day: Int
    
    @ObservedObject var vm: LessonListViewModel
    var dayLessons: [LessonViewModel]
    
    @State var isShowingLessonDetail: LessonViewModel? = nil
    
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
                                .background(lesson.color)
                                .overlay(RoundedRectangle(cornerRadius: 4)
                                    .stroke(.black, lineWidth: 1))
                                .padding(2)
                            
                            Text("\(lesson.title)")
                                .font(.myCustomFont(size: 12))
                                .foregroundColor(.gray)
                        }
                        Button(action: {
                            isShowingLessonDetail = lesson
                        }, label: {
                            ScheduleLessonCardView(lessonVM: vm, lessonID: lesson.id)
                                .foregroundColor(.black)
                        })
                    }
                }
                .sheet(item: $isShowingLessonDetail) { lesson in
                    LessonDetailView(lessonVM: vm, lessonID: lesson.id)
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
