import SwiftUI


struct EditLessonInfoView: View {
    /*
    @State var lessonTitle: String
    @State var startLessonDate: Date
    @State var endLessonDate: Date
    @State var selectedStudentID: UUID?
    @State var content: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
     
     */
    @Environment(\.dismiss) var dismiss
     
    @ObservedObject var lessonVM: LessonListViewModel
    var lessonID: UUID
    
    var body: some View {
        Text("  ")
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

