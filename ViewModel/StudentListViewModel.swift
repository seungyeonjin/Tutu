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
    
    func fetchStudentLessons(studentID: UUID) -> [LessonViewModel]
    {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Student.id), studentID as NSUUID)
        
        var lessonList = [LessonViewModel]()
        
        do {
            let student = try context.fetch(fetchRequest)
            let lessons = student[0].lessons?.allObjects as! [Lesson]
            lessonList = lessons.map(LessonViewModel.init)
            
        } catch  {
        }
        saveData()
        return lessonList
    }
    
    func fetchOneStudent(studentID: UUID) -> StudentViewModel {
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Student.id), studentID as NSUUID)
        
        var student = [StudentViewModel]()
        
        do {
            let studentsFetched = try context.fetch(fetchRequest)
            student.append(StudentViewModel(student: studentsFetched[0]))
            
            
        } catch  {
        }
        saveData()
        return student[0]
    }
    
    func updateStudents() {
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        do {
            let students = try context.fetch(fetchRequest)
            self.students = students.map(StudentViewModel.init)
        } catch {
            
        }
    }
    
    func addStudent(timestamp: Date, name: String, color: Color, location: String, contact: String) {
        let newStudent = Student(context: context)
        
        newStudent.timestamp = timestamp
        newStudent.id = UUID()
        newStudent.name = name
        newStudent.color = UIColor(color)
        newStudent.location = location
        newStudent.contact = contact
        
        saveData()
    }
    
    func editStudent(studentID: UUID, name: String, color: Color, location: String, contact: String, context: NSManagedObjectContext) {
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Student.id), studentID as NSUUID)
        
        do {
            let students = try context.fetch(fetchRequest)
            let student = students[0]
            
            
            student.name = name
            student.color = UIColor(color)
            student.location = location
            student.contact = contact
            
            for i in student.lessons?.allObjects as! [Lesson] {
                i.color = UIColor(color)
                i.location = location
            } // 이 부분 없이는 lesson object까지 업데이트 안됨
            // view에서 lesson.student.color 와 같이 코드 작성 대신 filter 사용해야 함
            
            saveData()
        } catch  {
        }
        
    }
    
    func deleteStudentAndLessons(id: UUID) {
        
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Lesson.student.id), id as NSUUID)
        
        do {
            let lessons = try context.fetch(fetchRequest)
            for lesson in lessons {
                context.delete(lesson)
            }
            
        } catch  {
        }
        
        let fetchRequest2: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest2.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Student.id), id as NSUUID)
        

        do {
            let students = try context.fetch(fetchRequest2)
            for student in students {
                context.delete(student)
            }
            
        } catch  {
        }
        saveData()
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
        student.id ?? UUID()
    }
    
    var name: String {
        student.name ?? ""
    }
    
    var color: Color {
        if let color: UIColor = student.color as? UIColor {
            return Color(color)
        } else {
            return .gray
        }
    }
    
    var contact: String {
        student.contact ?? ""
    }
    
    var lessons: [LessonViewModel] {
        let set: NSSet = student.lessons ?? NSSet()
        
        let lessonArray = set.allObjects as! [Lesson]
        var wrappedLessonArray: [LessonViewModel] = []
        for lesson in lessonArray {
            wrappedLessonArray.append(LessonViewModel(lesson: lesson))
        }
        return wrappedLessonArray
    }
    
    var timeStamp: Date {
        student.timestamp ?? Date()
    }
    
    var location: String {
        student.location ?? ""
    }
    
    
}

