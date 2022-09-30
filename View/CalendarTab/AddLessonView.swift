import SwiftUI

struct AddLessonView: View {
    
    let tempStartDate: Date
    let tempEndDate: Date
    @State var lessonTitle: String
    @State var startLessonDate: Date
    @State var endLessonDate: Date
    @State var selectedStudentID: UUID?
    @State var content: String = ""
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var lessonListVM: LessonListViewModel
    @ObservedObject var studentVM: StudentListViewModel
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Student:")
                    .font(.myCustomFont(size: 16))
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(studentVM.students, id: \.id) { student in
                            Button(action: {
                                    selectedStudentID = student.id
                            } , label: {
                                ZStack {
                                    Text("\(student.name)")
                                        .padding(5)
                                        .cornerRadius(4)
                                        .background(selectedStudentID == student.id ? student.color : Color(.systemGray6))
                                        .foregroundColor(selectedStudentID == student.id ? .black : .gray)
                                    RoundedRectangle(cornerRadius: 4).stroke(selectedStudentID == student.id ? .black : .gray)
                                }
                            })
                        }
                        Spacer()
                    }
                    .padding(2)
                }
                VStack(alignment: .leading) {
                    Spacer(minLength: 10)
                    Text("Lesson Title: ")
                        .font(.myCustomFont(size: 16))
                    TextField("Untitled", text: $lessonTitle)
                        .font(.myCustomFont(size: 16))
                        .padding()
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 4)
                            .fill(.black.opacity(0), strokeColor: .black))
                }
                VStack(alignment: .leading) {
                    Spacer(minLength: 10)
                    Text("Time: ")
                    DatePicker("Start", selection: $startLessonDate,
                        displayedComponents: [.date, .hourAndMinute])
                            .onChange(of: startLessonDate) { newValue in
                                endLessonDate = Calendar.current.date(byAdding: .hour, value: 1, to: newValue)! }
                    DatePicker("End", selection: $endLessonDate,
                                               displayedComponents: [.date, .hourAndMinute])
                }
                .font(.myCustomFont(size: 16))
                VStack(alignment: .leading) {
                    Spacer(minLength: 10)
                    Text("Content: ")
                        .font(.myCustomFont(size: 16))
                    ZStack {
                        TextEditor(text: $content)
                            .font(.custom("HelveticaNeue", size: 13))
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.gray.opacity(0), strokeColor: .black)
                    }
                    .frame(height: 200)
                }
            }
            .padding()
            .navigationTitle("Add new lesson")
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
                    Button() {
                        if lessonTitle.isEmpty || selectedStudentID != nil {
                            createLesson()
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark.rectangle")
                            .foregroundColor(lessonTitle.isEmpty || selectedStudentID == nil ? Color.gray : Color.black)
                    }
                }
            }
        }
    }
    
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
    
    func createLesson() {
        
        lessonListVM.addLesson(startLessonDate: startLessonDate, endLessonDate: endLessonDate, lessonTitle: lessonTitle, lessonContent: content, selectedStudentID: selectedStudentID!)
        
    }
}
