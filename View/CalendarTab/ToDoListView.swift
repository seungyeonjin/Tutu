
import SwiftUI

struct ToDoListView: View {
    
    @ObservedObject var lessonVM: LessonListViewModel
    var todoList: [ToDoItemViewModel]
    var color: Color
    
    init(lessonVM: LessonListViewModel, lessonId: UUID, color: Color) {
        self.lessonVM = lessonVM
        self.color = color
        todoList = lessonVM.fetchTodoList(lessonId)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ForEach(todoList, id: \.id) { todo in
                
                Button(action: {
                    if todo.done {
                        lessonVM.todoUndo(todo.id)
                    } else {
                        lessonVM.todoDone(todo.id)
                    }
                }, label: {
                    HStack {
                        if todo.done {
                            Image(systemName: "stop.fill")
                                .foregroundColor(color)
                        } else {
                            Image(systemName: "stop")
                                .foregroundColor(color)
                        }
                        Text(todo.name)
                            .font(.myCustomFont(size: 16))
                            .foregroundColor(.black)
                        Spacer()
                    }
                })
                .padding([.leading], 7)
                .padding([.bottom], 3)
            }
        }
        
    }
}
