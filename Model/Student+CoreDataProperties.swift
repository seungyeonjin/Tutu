

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var color: NSObject?
    @NSManaged public var contact: String?
    @NSManaged public var id: UUID?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var lessons: NSSet?

}

// MARK: Generated accessors for lessons
extension Student {

    @objc(addLessonsObject:)
    @NSManaged public func addToLessons(_ value: Lesson)

    @objc(removeLessonsObject:)
    @NSManaged public func removeFromLessons(_ value: Lesson)

    @objc(addLessons:)
    @NSManaged public func addToLessons(_ values: NSSet)

    @objc(removeLessons:)
    @NSManaged public func removeFromLessons(_ values: NSSet)

}
