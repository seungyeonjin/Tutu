import SwiftUI


struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.white.opacity(0))
                    .overlay(RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(Color.black, lineWidth: 1))
                    
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.white.opacity(0))
                    .overlay(RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(Color.black, lineWidth: 1))
                
                Button(action: {
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    viewModel.signUp(email: email, password: password)
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray, strokeColor: Color.black)
                        Text("Create Account")
                            .font(.myCustomFont(size: 18))
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 200, height: 50)
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Create Account")
                        .font(.myCustomFont(size: 20))
                }
            }
            .padding()
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
