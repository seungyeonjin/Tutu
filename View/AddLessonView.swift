import SwiftUI

struct AddLessonView: View {
    
    let tempStartDate: Date
    let tempEndDate: Date
    @State var lessonTitle: String
    @State var startLessonDate: Date
    @State var endLessonDate: Date
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Lesson Title", text: $lessonTitle)
                    .padding()
                    .background(
                        Color(UIColor.systemGray6)
                    )
                    .cornerRadius(10)
                Form {
                    Section {
                        DatePicker("Start", selection: $startLessonDate,
                                   displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                    } header: {
                        Text("Start")
                    }
                    
                    Section {
                        DatePicker("End", selection: $endLessonDate,
                                   displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                    } header: {
                        Text("End")
                    }
                }
                
            }
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
                        createLesson()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.rectangle")
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
    
    init() {
        tempStartDate = Date()
        tempEndDate = Calendar.current.date(byAdding: .hour, value: 1, to: tempStartDate)!
        
        _lessonTitle = State(initialValue: "")
        _startLessonDate = State(initialValue: tempStartDate)
        _endLessonDate = State(initialValue: tempEndDate)
    }
    
    func createLesson() {
        
        // create a Lesson
        let newLesson = Lesson(context: viewContext)
        newLesson.startDate = startLessonDate
        newLesson.endDate = endLessonDate
        newLesson.done = endLessonDate < Date.now ? true : false
        newLesson.id = UUID()
        newLesson.title = lessonTitle
        
        
        newLesson.students = []

        // save context
        try! viewContext.save()
    }
}

struct AddLessonView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddLessonView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
