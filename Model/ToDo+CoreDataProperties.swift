
import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var done: Bool
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var inLesson: Lesson?

}
