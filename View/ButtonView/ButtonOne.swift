
import SwiftUI

struct ButtonOne: View {
    
    var buttonName: String
    var textColor: Color = .black
    var backgroundColor: Color = Color(UIColor.systemGray5)
    
    var body: some View {
        Text(buttonName)
            .foregroundColor(textColor)
            .font(.myCustomFont(size: 16))
            .padding(2)
            .background(backgroundColor)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(.black))
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
        ButtonOne(buttonName: "Edit")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
