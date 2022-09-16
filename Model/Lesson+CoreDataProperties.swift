//
//  Lesson+CoreDataProperties.swift
//  Tutu
//
//  Created by 진승연 on 2022/09/16.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var done: Bool

}

extension Lesson : Identifiable {

}
