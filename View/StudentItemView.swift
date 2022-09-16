import SwiftUI

struct StudentItemView: View {
    
    let student: Student
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(student.name ?? "")
                    .font(.title2)
                    .fontWeight(.heavy)
                
                Text(student.location ?? "")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing, 8)
            } //: VSTACK
        } //: HSTACK
    }
}
