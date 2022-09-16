//
//  DaySchedule+CoreDataProperties.swift
//  Tutu
//
//  Created by 진승연 on 2022/09/16.
//
//

import Foundation
import CoreData


extension DaySchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DaySchedule> {
        return NSFetchRequest<DaySchedule>(entityName: "DaySchedule")
    }

    @NSManaged public var date: Date?

}

extension DaySchedule : Identifiable {

}
