import SwiftUI

struct StudentDetailView: View {
    
    @ObservedObject var studentVM: StudentListViewModel

    var studentID: UUID
    var student: StudentViewModel
    
    @State var isShowingEditSheet = false
    @State var isShowingRemoveAlert = false
    
    init(vm: StudentListViewModel, studentID: UUID) {
        self.studentID = studentID
        self.studentVM = vm
        self.student = vm.fetchOneStudent(studentID: studentID)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("@ \(student.location)")
                Text("\(student.contact)")
                Spacer()
                VStack(alignment: .leading) {
                    Text("Lesson History")
                        .font(.myCustomFont(size: 16))
                    ScrollView {
                        let studentLessons = student.lessons
                        let studentLessonsSorted = studentLessons.sorted(by: { $0.startDate > $1.startDate })
                        ForEach(studentLessonsSorted, id: \.id) { lesson in
                            VStack(alignment: .leading) {
                                Text(lesson.title)
                                Text(CalendarHelper().dayMonthYearString(lesson.startDate))
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .border(.black)
                        }
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(student.name)
                        .font(.myCustomFont(size: 35))
                      .foregroundColor(Color.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            isShowingEditSheet = true
                        }, label: {
                            Text("Edit")
                                .foregroundColor(.black)
                                .font(.myCustomFont(size: 16))
                                .padding(2)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(.black))
                        })
                        .sheet(isPresented: $isShowingEditSheet) {
                            EditStudentView(studentID: studentID, studentName: student.name, location: student.location, studentColor: student.color, contact: student.contact, studentVM: studentVM)
                        }
                        
                        Button(action: {
                            isShowingRemoveAlert = true
                        }, label: {
                            Text("Remove")
                                .foregroundColor(.red)
                                .font(.myCustomFont(size: 16))
                                .padding(2)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(.black))
                            // alert - are you sure you want to remove?
                        })
                        .alert(isPresented: $isShowingRemoveAlert) {
                            Alert(title: Text("Are you sure?"),
                                  message: Text("If you select yes, " + "their lessons will be removed as well"),
                                  primaryButton: .destructive(Text("Yes"), action: {
                                studentVM.deleteStudentAndLessons(id: studentID) }),
                                  secondaryButton: .cancel(Text("Cancel")))
                        }
                    }
                }
            }
        }
    }
}
