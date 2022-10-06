import Foundation
import SwiftUI
import CoreData





struct ToDoItemViewModel: Identifiable {
    private var todoItem: ToDo
    
    init(todoItem: ToDo) {
        self.todoItem = todoItem
    }
    
    var id: UUID {
        todoItem.id ?? UUID()
    }
    
    var done: Bool {
        todoItem.done
    }
    
    var name: String {
        todoItem.name ?? ""
    }
    
    var inLesson: LessonViewModel? {
        if let lesson: Lesson = todoItem.inLesson {
            return LessonViewModel.init(lesson: lesson)
        } else {
            return nil
        }
    }
}
