//
//  Lesson+CoreDataProperties.swift
//  
//
//  Created by 진승연 on 2022/10/06.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var color: NSObject?
    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var location: String?
    @NSManaged public var memo: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var summary: String?
    @NSManaged public var student: Student?
    @NSManaged public var todos: NSSet?

}

// MARK: Generated accessors for todos
extension Lesson {

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: ToDo)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: ToDo)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSSet)

}
