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
    
    func addLesson(startLessonDate: Date, endLessonDate: Date, lessonTitle: String, selectedStudentID: UUID ) {
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "%K==%@", #keyPath(Student.id), selectedStudentID as NSUUID)

        do {
            let students = try context.fetch(fetchRequest)
            let newLesson = Lesson(context: context)
            
            newLesson.startDate = startLessonDate
            newLesson.endDate = endLessonDate
            newLesson.done = endLessonDate < Date.now ? true : false
            newLesson.id = UUID()
            newLesson.title = lessonTitle
            newLesson.student = students[0]
            newLesson.color = students[0].color as! UIColor
            
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
        lesson.id!
    }
    
    var title: String {
        lesson.title!
    }
    
    var color: Color {
        Color(lesson.color as! UIColor)
    }
    
    var content: String {
        lesson.content ?? ""
    }
    
    var done: Bool {
        lesson.done
    }
    
    var endDate: Date {
        lesson.endDate!
    }
    var startDate: Date {
        lesson.startDate!
    }
    
    var location: String {
        lesson.location!
    }
    
    var student: StudentViewModel {
        StudentViewModel.init(student: lesson.student!)
    }
}
