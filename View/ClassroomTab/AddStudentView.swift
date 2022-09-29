import SwiftUI

struct AddStudentView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var studentName: String = ""
    @State var location: String = ""
    
    @State var studentColor = Color.red
    @ObservedObject var studentVM: StudentListViewModel
    
    
    private func addStudent() -> Bool {
        if (studentName.isEmpty || location.isEmpty) {
            return false
        }
        
        studentVM.addStudent(timestamp: Date(), name: studentName, color: studentColor, location: location)
        return true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Student Name", text: $studentName)
                    .disableAutocorrection(true)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0), strokeColor: Color.black))
                TextField("Location", text: $location)
                    .disableAutocorrection(true)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0), strokeColor: Color.black))
                ColorPicker("Set a color for this student", selection: $studentColor)
                Spacer()
            }
            .padding()
            .navigationTitle("Add New Student")
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
                        if addStudent() {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark.rectangle")
                            .foregroundColor((studentName.isEmpty || location.isEmpty) ? Color.gray : Color.black)
                    }
                }
            }
        }
    }
}
    /*
    
    init() {
        tempStartDate = Date()
        tempEndDate = Calendar.current.date(byAdding: .hour, value: 1, to: tempStartDate)!
        
        _lessonTitle = State(initialValue: "")
        _startLessonDate = State(initialValue: tempStartDate)
        _endLessonDate = State(initialValue: tempEndDate)
    }
     */

