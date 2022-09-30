//
//  Lesson+CoreDataProperties.swift
//  
//
//  Created by 진승연 on 2022/10/01.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var color: NSObject?
    @NSManaged public var content: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var location: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var student: Student?

}
