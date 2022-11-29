import SwiftUI

struct StudentDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var studentVM: StudentListViewModel

    var studentID: UUID
    var student: StudentViewModel
    
    @State var isShowingEditSheet = false
    @State var isShowingRemoveAlert = false
    @State var isShowingLessonDetail: LessonViewModel? = nil
    
    init(vm: StudentListViewModel, studentID: UUID) {
        self.studentID = studentID
        self.studentVM = vm
        self.student = vm.fetchOneStudent(studentID: studentID)
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(student.name)
                    .font(.myCustomFont(size: 35))
                  .foregroundColor(Color.black)
                Spacer()
                HStack {
                    Button(action: {
                        isShowingEditSheet = true
                    }, label: {
                        ButtonOne(buttonName: "Edit")
                    })
                    .sheet(isPresented: $isShowingEditSheet) {
                        EditStudentView(studentID: studentID, studentName: student.name, location: student.location, studentColor: student.color, contact: student.contact, studentVM: studentVM)
                    }
                    Button(action: {
                        isShowingRemoveAlert = true
                    }, label: {
                        ButtonOne(buttonName: "Remove", textColor: .red)
                    })
                    .alert(isPresented: $isShowingRemoveAlert) {
                        Alert(title: Text("Are you sure?"),
                              message: Text("If you select yes, " + "their lessons will be removed as well"),
                              primaryButton: .destructive(Text("Yes"), action: {
                            studentVM.deleteStudentAndLessons(id: studentID) }),
                              secondaryButton: .cancel(Text("Cancel")))
                    }
                }
            } // : HSTACK
            .padding([.leading, .trailing, .top])
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "house")
                    Text("\(student.location)")
                }
                Spacer()
                HStack {
                    Image(systemName: "phone")
                    Text("\(student.contact)")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Lesson History")
                        .font(.myCustomFont(size: 16))
                        .fontWeight(.bold)
                    ScrollView {
                        let studentLessons = student.lessons
                        let studentLessonsSorted = studentLessons.sorted(by: { $0.startDate > $1.startDate })
                        ForEach(studentLessonsSorted, id: \.id) { lesson in
                            Button(action: {
                                    isShowingLessonDetail = lesson
                            }, label: {
                                HStack() {
                                    Text(CalendarHelper().dayMonthYearString(lesson.startDate))
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                        .font(.myCustomFont(size: 13))
                                    
                                    Spacer()
                                    Text(lesson.title)
                                        .foregroundColor(.black)
                                        .font(.myCustomFont(size: 15))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .border(.black)
                            })
                            .sheet(item: $isShowingLessonDetail) { lesson in
                                LessonDetailView(lessonVM: LessonListViewModel(context: viewContext), lessonID: lesson.id)
                            }
                        }
                    }
                }
            }//:VSTACK
            .padding()
        } //:VSTACK
    }
}
