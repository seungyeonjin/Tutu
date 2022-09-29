import Foundation
import SwiftUI
import CoreData

@MainActor
class StudentListViewModel: NSObject, ObservableObject {
    
    @Published var students = [StudentViewModel]()
    
    private let fetchedResultsController: NSFetchedResultsController<Student>
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        request.sortDescriptors = []
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let students = fetchedResultsController.fetchedObjects else {
                return
            }
            self.students = students.map(StudentViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func addStudent(timestamp: Date, name: String, color: Color, location: String) {
        let newStudent = Student(context: context)
        
        newStudent.timestamp = timestamp
        newStudent.id = UUID()
        newStudent.name = name
        newStudent.color = UIColor(color)
        newStudent.location = location
        
        saveData()
    }
    
    func deleteStudent(id: UUID) {
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Student.id), id as NSUUID)
        

        do {
            let students = try context.fetch(fetchRequest)
            for student in students {
                context.delete(student)
            }
            saveData()
        } catch  {
        }
    }
    
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    
}

extension StudentListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let students = controller.fetchedObjects as? [Student] else {
            return
        }
        self.students = students.map(StudentViewModel.init)
    }
}

struct StudentViewModel: Identifiable {
    private var student: Student
    
    init(student: Student) {
        self.student = student
    }
    
    var id: UUID {
        student.id!
    }
    
    var name: String {
        student.name!
    }
    
    var color: Color {
        Color(student.color as! UIColor)
    }
    
    var lessons: [Lesson] {
        let set: NSSet = student.lessons ?? NSSet()
        return set.allObjects as! [Lesson]
    }
    
    var timeStamp: Date {
        student.timestamp!
    }
    
    var location: String {
        student.location!
    }
    
    
}

