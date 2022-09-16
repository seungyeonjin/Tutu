import SwiftUI

struct ClassroomView: View {
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Student.timestamp, ascending: true)],
        animation: .default)
    private var students: FetchedResults<Student>

    // MARK: - FUNCTION
    
    private func addStudent() {
        withAnimation {
            let newStudent = Student(context: viewContext)
            newStudent.id = UUID()
            newStudent.timestamp = Date()
            newStudent.location = ""
            newStudent.name = "name"
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteStudent(offsets: IndexSet) {
        withAnimation {
            offsets.map { students[$0]
            }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(students) { student in
                        NavigationLink {
                            Text("\(student.name ?? "")")
                        } label: {
                            StudentItemView(student: student)
                        }
                    }
                    .onDelete(perform: deleteStudent)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addStudent) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct ClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomView()
    }
}
