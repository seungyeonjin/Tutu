import SwiftUI

struct DayView: View {
    
    let year: Int
    let month: Int
    let day: Int
    
    @State var isShowingLessonDetail: LessonViewModel? = nil
    
    @ObservedObject var vm: LessonListViewModel
    var dayLessons: [LessonViewModel]
    
    let cal = CalendarHelper()
    
    init(year: Int, month: Int, day: Int, vm: LessonListViewModel) {
        self.year = year
        self.month = month
        self.day = day
        self.vm = vm
        self.dayLessons = vm.lessonsOnDate(year: year, month: month, day: day) 
    }
    
    var body: some View {
        let date = Date.from(year:year, month: month, day: day)!
        let dateString = cal.dayMonthYearString(date)
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    ZStack {
                        ForEach(0..<24) { d in
                            Path() { path in
                                path.move(to: CGPoint(x: 0, y: 25*d))
                                path.addLine(to: CGPoint(x: 500, y: 25*d))
                            }
                            .stroke(.gray)
                        }
                        
                        VStack {
                            ForEach(dayLessons, id: \.id) { lesson in
                                
                                Button(action: {
                                    isShowingLessonDetail = lesson
                                }, label: {
                                    DayLessonCardView(lessonVM: vm, lessonID: lesson.id)
                                })
                            }
                            .sheet(item: $isShowingLessonDetail) { lesson in
                                LessonDetailView(lessonVM: vm, lessonID: lesson.id)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    VStack {
                        Text(dateString).font(.myCustomFont(size: 20))
                    }
                }
            }
            
        }
    }
}

