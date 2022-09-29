import SwiftUI

struct CalendarCell: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    let year: Int
    let month: Int
    let day: Int
    let textColor: Color
    
    @ObservedObject var vm: LessonListViewModel
    var dateVM = DateViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(day)")
                .foregroundColor(textColor)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(1)
            InsetCalendarCellView(year: year, month: month, day: day,  vm: vm)
                .frame(maxWidth: .infinity)
        }
    }
}
