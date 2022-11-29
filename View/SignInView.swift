import SwiftUI
import FirebaseAuth



struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Text("Welcome to Tutu!")
                    .font(.myCustomFont(size: 20))
                    .padding()
                Image("Tutu")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                ZStack {
                    TextField("Email Address", text: $email)
                        .font(.myCustomFont(size: 16))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white.opacity(0))
                        .overlay(RoundedRectangle(cornerRadius: 2)
                            .strokeBorder(viewModel.wrongEmail ? Color.red : Color.black, lineWidth: 1))
                }
                
                ZStack {
                    SecureField("Password", text: $password)
                        .font(.myCustomFont(size: 16))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white.opacity(0))
                        .overlay(RoundedRectangle(cornerRadius: 2)
                            .strokeBorder(viewModel.wrongPassword ? Color.red : Color.black, lineWidth: 1))
                }
                
                if viewModel.wrongEmail || viewModel.wrongPassword {
                    Text("Wrong input. Please try again.")
                        .foregroundColor(Color.red)
                        .font(.caption)
                }
                
                
                Button(action: {
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    viewModel.signIn(email: email, password: password)
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray, strokeColor: Color.black)
                        Text("Sign In")
                            .font(.myCustomFont(size: 20))
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                    }
                    .frame(width: 200, height: 50)
                })
                
                Spacer(minLength:70)
                
                VStack {
                    Text("New to Tutu?")
                        .font(.myCustomFont(size: 14))
                    NavigationLink(destination: SignUpView(), label: {
                        Text("Create Account")
                            .font(.myCustomFont(size: 14))
                            .foregroundColor(Color.black)
                            .frame(width: 150, height:35)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0), strokeColor: Color.black))
                    })
                }
                .padding()
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Sign In")
                        .font(.myCustomFont(size: 20))
                }
            }
            .padding()
        }
        .accentColor(Color.black)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
