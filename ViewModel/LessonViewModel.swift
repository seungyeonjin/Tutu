import Foundation
import SwiftUI
import CoreData


@MainActor
class LessonListViewModel: NSObject, ObservableObject {
    
    @Published var lessons = [LessonViewModel]()
    @Published var todos = [ToDoItemViewModel]()
    
    private (set) var context: NSManagedObjectContext
    private let fetchedResultsController: NSFetchedResultsController<Lesson>

    init(context: NSManagedObjectContext) {
        
        self.context = context
        
        let requestTodo: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        do {
            let todoList = try context.fetch(requestTodo)
            self.todos = todoList.map(ToDoItemViewModel.init)
        } catch {
            
        }
        
        
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        request.sortDescriptors = []
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            guard let lessons = fetchedResultsController.fetchedObjects else {
                return
            }
            self.lessons = lessons.map(LessonViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func createToDo(name: String, lesson: Lesson) {
        let newTodo = ToDo(context: context)
        
        newTodo.done = false
        newTodo.name = name
        newTodo.id = UUID()
        newTodo.inLesson = lesson
        
        saveData()
    }
    
    func todoDone(_ todoId: UUID) {
        
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(ToDo.id), todoId as NSUUID)

        do {
            let todo = try context.fetch(fetchRequest)
            if todo.first != nil {
                todo.first!.done = true
                updateTodoList()
                saveData()
            }
        } catch {
            
        }
    }
    
    func todoUndo(_ todoId: UUID) {
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(ToDo.id), todoId as NSUUID)

        do {
            let todo = try context.fetch(fetchRequest)
            if todo.first != nil {
                todo.first!.done = false
                updateTodoList()
                saveData()
            }
        } catch {
            
        }
    }
    
    func fetchTodoList(_ lessonId: UUID) -> [ToDoItemViewModel] {
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Lesson.id), lessonId as NSUUID)

        do {
            let lesson = try context.fetch(fetchRequest)
            if lesson.first != nil {
                let todoList = lesson.first!.todos?.allObjects as! [ToDo]
                let lessonTodo = todoList.map(ToDoItemViewModel.init)
                return lessonTodo
            }
        } catch {
            
        }
        return []
    }
    
    
    func updateTodoList() {
        objectWillChange.send()
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do {
            let todos = try context.fetch(request)
            self.todos = todos.map(ToDoItemViewModel.init)
        } catch {
            
        }
    }
    
    
    func update() {
        objectWillChange.send()
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        do {
            let lessons = try context.fetch(request)
            self.lessons = lessons.map(LessonViewModel.init)
        } catch {
            
        }
    }
    
    func lessonOfId(lessonID: UUID) -> LessonViewModel? {
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Lesson.id), lessonID as NSUUID)

        let firstLesson: LessonViewModel
        do {
            let lesson = try context.fetch(fetchRequest)
            if lesson.first != nil {
                firstLesson = LessonViewModel(lesson: lesson.first!)
                saveData()
                return firstLesson
            }
        } catch {
            
        }
        return nil
    }
     
    
    func lessonsOnDate(year: Int, month: Int, day: Int) -> [LessonViewModel] {
        
        let startOfDate = Date.from(year: year, month: month, day: day)!
        let endOfDate = Calendar.current.date(byAdding: .day, value: 1, to: startOfDate)!
        
        let startPredicate1 = NSPredicate(format: "startDate >= %@", startOfDate as NSDate)
        let startPredicate2 = NSPredicate(format: "startDate < %@", endOfDate as NSDate)
        let startPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [startPredicate1, startPredicate2])
        
        let endPredicate1 = NSPredicate(format: "endDate >= %@", startOfDate as NSDate)
        let endPredicate2 = NSPredicate(format: "endDate < %@", endOfDate as NSDate)
        let endPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [endPredicate1, endPredicate2])
        
        let datePredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [startPredicate, endPredicate])
        
        let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: true)
        let sortDescriptors = [sortDescriptor]
        
        
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        request.predicate = datePredicate
        request.sortDescriptors = sortDescriptors
        var dayLessons = [LessonViewModel]()
        do { 
            let lessons = try context.fetch(request)
            
            dayLessons = lessons.map(LessonViewModel.init)
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
        return dayLessons
    }
    
    func addLesson(startLessonDate: Date, endLessonDate: Date, lessonTitle: String, lessonContent: String, selectedStudentID: UUID ) -> Lesson? {
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Student.id), selectedStudentID as NSUUID)

        do {
            let students = try context.fetch(fetchRequest)
            let newLesson = Lesson(context: context)
            
            newLesson.startDate = startLessonDate
            newLesson.endDate = endLessonDate
            newLesson.id = UUID()
            newLesson.title = lessonTitle
            newLesson.student = students[0]
            newLesson.memo = lessonContent
            newLesson.color = students[0].color as! UIColor
            
            saveData()
            return newLesson
        } catch {
            return nil
        }
        
    }
    
    func editLesson(lessonID: UUID, startLessonDate: Date, endLessonDate: Date, lessonTitle: String, lessonContent: String, selectedStudentID: UUID) {
        
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Lesson.id), lessonID as NSUUID)

        do {
            let lessonList = try context.fetch(fetchRequest)
            let lesson: Lesson = lessonList.first!
            
            lesson.startDate = startLessonDate
            lesson.endDate = endLessonDate
            lesson.title = lessonTitle
            lesson.memo = lessonContent
            
        } catch {
            return
        }
        
        
        saveData()
    }
    
    func deleteLesson(lessonID: UUID) {
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Lesson.id), lessonID as NSUUID)
        
        do {
            let lessonList = try context.fetch(fetchRequest)
            let lesson: Lesson = lessonList.first!
            
            for todo in lesson.todos!.allObjects as! [ToDo] {
                context.delete(todo)
            }
            
            context.delete(lesson)
            
        } catch {
            
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

extension LessonListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let lessons = controller.fetchedObjects as? [Lesson] else {
            return
        }
        self.lessons = lessons.map(LessonViewModel.init)
    }
}

struct LessonViewModel: Identifiable {
    private var lesson: Lesson
    
    init(lesson: Lesson) {
        self.lesson = lesson
    }
    
    var id: UUID {
        lesson.id ?? UUID()
    }
    
    var title: String {
        lesson.title ?? ""
    }
    
    var color: Color {
        if let color: UIColor = lesson.color as? UIColor {
            return Color(color)
        } else {
            return .gray
        }
    }
    
    var memo: String {
        lesson.memo ?? ""
    }
    var endDate: Date {
        lesson.endDate ?? Date()
    }
    var startDate: Date {
        lesson.startDate ?? Date()
    }
    
    var location: String {
        lesson.location ?? ""
    }
    
    var student: StudentViewModel? {
        if let student = lesson.student {
            return StudentViewModel.init(student: student)
        } else {
            return nil
        }
    }
    
    var todos: [ToDoItemViewModel] {
        let set: NSSet = lesson.todos ?? NSSet()
        let todoArray = set.allObjects as! [ToDo]
        var wrappedTodoArray: [ToDoItemViewModel] = []
        for todo in todoArray {
            wrappedTodoArray.append(ToDoItemViewModel(todoItem: todo))
        }
        return wrappedTodoArray
    }
}
