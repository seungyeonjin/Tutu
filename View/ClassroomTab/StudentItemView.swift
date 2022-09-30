import SwiftUI

struct StudentItemView: View {
    
    @ObservedObject var studentVM: StudentListViewModel
    var studentName: String
    var studentColor: Color
    var studentLocation: String
    
    var body: some View {
        HStack() {
            ZStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 55, weight: .thin))
                    .foregroundColor(studentColor)
                Image(systemName: "person")
                    .font(.system(size: 55, weight: .ultraLight))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(studentName)
                    .font(.myCustomFont(size: 18))
                    .fontWeight(.heavy)
                
                Text(studentLocation)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .padding(.trailing, 8)
            } //: VSTACK
            
            Spacer()
        } //: HSTACK
    }
}
