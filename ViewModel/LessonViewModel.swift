import Foundation
import SwiftUI
import CoreData
/*
class LessonViewModel: ObservableObject {
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    var year: Int
    var month: Int
    var day: Int

    @Published var dayLessons = [Lesson]()
    
    init() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        year = calendarDate.year!
        month = calendarDate.month!
        day = calendarDate.day!

    }
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
        
        fetchDayLessons()
    }
    
    func fetchDayLessons(startDate: Date) -> [Lesson] {
        
        let startOfDate = startDate
        let endOfDate = Calendar.current.date(byAdding: .day, value: 1, to: startOfDate)!
        
        let startPredicate1 = NSPredicate(format: "startDate >= %@", startOfDate as NSDate)
        let startPredicate2 = NSPredicate(format: "startDate < %@", endOfDate as NSDate)
        let startPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [startPredicate1, startPredicate2])
        
        let endPredicate1 = NSPredicate(format: "endDate >= %@", startOfDate as NSDate)
        let endPredicate2 = NSPredicate(format: "endDate < %@", endOfDate as NSDate)
        let endPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [endPredicate1, endPredicate2])
        
        let datePredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [startPredicate, endPredicate])
        
        
        
    }
    
    func fetchDayLessons() {
        
        let startOfDate = Date.from(year: year, month: month, day: day)!
        let endOfDate = Calendar.current.date(byAdding: .day, value: 1, to: startOfDate)!
        
        let startPredicate1 = NSPredicate(format: "startDate >= %@", startOfDate as NSDate)
        let startPredicate2 = NSPredicate(format: "startDate < %@", endOfDate as NSDate)
        let startPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [startPredicate1, startPredicate2])
        
        let endPredicate1 = NSPredicate(format: "endDate >= %@", startOfDate as NSDate)
        let endPredicate2 = NSPredicate(format: "endDate < %@", endOfDate as NSDate)
        let endPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [endPredicate1, endPredicate2])
        
        let datePredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [startPredicate, endPredicate])
        
        
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        request.predicate = datePredicate
        do {
            dayLessons = try viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    
    
    func deleteLesson(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let lesson = dayLessons[index]
        viewContext.delete(lesson)
        saveData()
    }
    
    
}
*/

@MainActor
class LessonListViewModel: NSObject, ObservableObject {
    
    @Published var lessons = [LessonViewModel]()
    // @Published var dayLessons = [LessonViewModel]()
    
    private let fetchedResultsController: NSFetchedResultsController<Lesson>
    
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
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
    
    func update() {
        objectWillChange.send()
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        do {
            let lessons = try context.fetch(request)
            self.lessons = lessons.map(LessonViewModel.init)
        } catch {
            
        }
    }
    
    func lessonOfId(lessonID: UUID) -> LessonViewModel {
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Lesson.id), lessonID as NSUUID)

        var lessonOfId: LessonViewModel? = nil
        do {
            let lesson = try context.fetch(fetchRequest)
            lessonOfId = lesson.map(LessonViewModel.init)[0]
            
        } catch {
            
        }
        
        return lessonOfId!
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
        
        
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        request.predicate = datePredicate
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
    
    func addLesson(startLessonDate: Date, endLessonDate: Date, lessonTitle: String, lessonContent: String, selectedStudentID: UUID ) {
        
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
            newLesson.content = lessonContent
            newLesson.color = students[0].color as! UIColor
            
        } catch {
            return
        }
        
        saveData()
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
            lesson.content = lessonContent
            
        } catch {
            return
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
    
    var content: String {
        lesson.content ?? ""
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
}
