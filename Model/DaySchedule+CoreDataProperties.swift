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
