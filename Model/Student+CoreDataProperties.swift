//
//  Student+CoreDataProperties.swift
//  Tutu
//
//  Created by 진승연 on 2022/09/16.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var timestamp: Date?

}

extension Student : Identifiable {

}
