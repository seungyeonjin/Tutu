import SwiftUI


struct LessonDetailView: View {
    
    @State var isEditMode = false
    @State var isShowingRemoveAlert = false
    
    let cal = CalendarHelper()
    
    @Environment(\.dismiss) var dismiss
     
    @ObservedObject var lessonVM: LessonListViewModel
    var lessonID: UUID
    
    var body: some View {
        if let lesson = lessonVM.lessonOfId(lessonID: lessonID) {
        
            VStack {
                HStack {
                    Button() {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    
                    HStack {
                        Button() {
                            if isEditMode {
                                // editLesson()
                                isEditMode = false
                            } else {
                                isEditMode = true
                            }
                        } label: {
                            if isEditMode {
                                ButtonOne(buttonName: "Save", textColor: .blue)
                            } else {
                                ButtonOne(buttonName: "Edit")
                            }
                        }
                        Button() {
                            isShowingRemoveAlert = true
                        } label: {
                            ButtonOne(buttonName: "Remove", textColor: .red)
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
                .padding([.leading, .trailing, .top])
                
                VStack(alignment: .leading) {
                    let startString = cal.hm(lesson.startDate)
                    let endString = cal.hm(lesson.endDate)
                    Text(lesson.title)
                        .font(.myCustomFont(size: 30))
                        .padding([.top], 10)
                    HStack {
                        ButtonOne(buttonName: "\(startString) ~ \(endString)")
                        ButtonOne(buttonName: "\(lesson.student?.name ?? "Unknown")", backgroundColor: lesson.color)
                        Spacer()
                    }
                    .padding([.leading])
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            // -------- TODO LIST -------- //
                            VStack(alignment: .leading) {
                                Text("Lesson Plans")
                                    .font(.myCustomFont(size: 18))
                                    .padding([.bottom], 2)
                                ToDoListView(lessonVM: lessonVM, lessonId: lessonID, color: lesson.color)
                                    .padding()
                                    .border(.black)
                            }
                            
                            // -------- MEMO -------- //
                            VStack(alignment: .leading) {
                                Text("Memo")
                                    .font(.myCustomFont(size: 18))
                                    .padding([.bottom], 2)
                                VStack {
                                    Text(lesson.memo)
                                        .font(.myCustomFont(size: 16))
                                        .padding()
                                    HStack {
                                        Spacer()
                                    }
                                }
                                .border(.black)
                                
                                
                            }
                        }
                    }
                    .padding()
                }
                .padding([.leading, .trailing])
            }
        }
        else {
            Text("")
        }
    }
}

