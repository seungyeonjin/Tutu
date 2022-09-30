import SwiftUI

struct EditStudentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    var studentID: UUID
    @State var studentName: String
    @State var location: String
    @State var studentColor: Color
    @State var contact: String
    
    @ObservedObject var studentVM: StudentListViewModel
    
    
    private func editStudent() -> Bool {
        if (studentName.isEmpty || location.isEmpty) {
            return false
        }
        
        studentVM.editStudent(studentID: studentID, name: studentName, color: studentColor, location: location, contact: contact, context: viewContext)
        
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
                TextField("Contact", text: $location)
                    .disableAutocorrection(true)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0), strokeColor: Color.black))
                ColorPicker("Set a color for this student", selection: $studentColor)
                Spacer()
            }
            .padding()
            .navigationTitle("Edit Student Info")
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
                        if editStudent() {
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
