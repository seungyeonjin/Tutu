import SwiftUI


struct LessonDetailView: View {
    /*
    @State var lessonTitle: String
    @State var startLessonDate: Date
    @State var endLessonDate: Date
    @State var selectedStudentID: UUID?
    @State var content: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
     
     */
    @State var isEditMode = false
    @State var isShowingRemoveAlert = false
    
    @Environment(\.dismiss) var dismiss
     
    @ObservedObject var lessonVM: LessonListViewModel
    var lessonID: UUID
    
    var body: some View {
        NavigationView {
            if let lesson = lessonVM.lessonOfId(lessonID: lessonID) {
                VStack {
                    Text(lesson.title)
                        .font(.myCustomFont(size: 20))
                    Text("\(lesson.student?.name ?? "Unknown")")
                        .font(.myCustomFont(size: 16))
                        .padding(4)
                        .background(lesson.color)
                        .cornerRadius(4)
                        .border(.black)
                        .cornerRadius(4)
                    
                    VStack {
                        Text(lesson.content)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button() {
                                dismiss()
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(Color.black)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Button() {
                                    if isEditMode {
                                        // editLesson()
                                    } else {
                                        isEditMode = true
                                    }
                                    
                                } label: {
                                    if isEditMode {
                                        Text("Save")
                                    } else {
                                        Text("Edit")
                                            .foregroundColor(.black)
                                            .font(.myCustomFont(size: 16))
                                            .padding(2)
                                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(.black))
                                    }
                                }
                                Button() {
                                    isShowingRemoveAlert = true
                                } label: {
                                    Text("Remove")
                                        .foregroundColor(.red)
                                        .font(.myCustomFont(size: 16))
                                        .padding(2)
                                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(.black))
                                }
                                .alert(isPresented: $isShowingRemoveAlert) {
                                    Alert(title: Text("Remove this Lesson?"),
                                          primaryButton: .destructive(Text("Yes"), action: {
                                            lessonVM.deleteLesson(lessonID: lesson.id)
                                            dismiss()
                                        }),
                                          secondaryButton: .cancel(Text("Cancel")))
                                }
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            else {
                Text("")
            }
        }
    }
    /*
    init(vm: LessonListViewModel, studentVM: StudentListViewModel) {
        tempStartDate = Date()
        tempEndDate = Calendar.current.date(byAdding: .hour, value: 1, to: tempStartDate)!
        
        _lessonTitle = State(initialValue: "Untitled")
        _startLessonDate = State(initialValue: tempStartDate)
        _endLessonDate = State(initialValue: tempEndDate)
        _selectedStudentID = State(initialValue: nil)
        
        lessonListVM = vm
        self.studentVM = studentVM
    }
    
    func editLesson(lessonVM: LessonListViewModel, lessonID: UUID) {
        
        lessonVM.editLesson(lessonID: lesson.id, startLessonDate: startLessonDate, endLessonDate: endLessonDate, lessonTitle: lessonTitle, lessonContent: content, selectedStudentID: selectedStudentID!)
        
    }
     */
}

