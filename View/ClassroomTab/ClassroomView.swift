import SwiftUI

struct ClassroomView: View {
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isShowingAddSheet: Bool = false
    @ObservedObject var studentVM: StudentListViewModel

    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ForEach(studentVM.students, id: \.id) { student in
                    NavigationLink {
                        Text("\(student.name)")
                            .foregroundColor(.black)
                    } label: {
                        StudentItemView(student: student)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Classroom")
                        .font(.system(size: 20, design: .serif))
                      .foregroundColor(Color.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingAddSheet = true
                    }, label: {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color.gray.opacity(0.2))
                                .font(.system(size: 15))
                            Image(systemName: "plus.circle")
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(Color.black)
                        }
                    })
                    .sheet(isPresented: $isShowingAddSheet) {
                        AddStudentView(studentVM: studentVM)
                    }
                }
            }
        }
    }
}
