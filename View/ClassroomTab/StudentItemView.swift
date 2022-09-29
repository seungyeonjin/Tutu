import SwiftUI

struct StudentItemView: View {
    
    let student: StudentViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            ZStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 55, weight: .thin))
                    .foregroundColor(student.color)
                Image(systemName: "person")
                    .font(.system(size: 55, weight: .ultraLight))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(student.name)
                    .font(.myCustomFont(size: 18))
                    .fontWeight(.heavy)
                
                Text(student.location)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .padding(.trailing, 8)
            } //: VSTACK
        } //: HSTACK
    }
}
