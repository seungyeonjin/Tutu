import SwiftUI
import Firebase

class AppViewModel: ObservableObject {
    
    var auth = Auth.auth()
    
    
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    @Published var signedIn = false
    @Published var wrongPassword = false
    @Published var wrongEmail = false
    
    func signout() {
        do {
            try auth.signOut()
            signedIn = false
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self]
            result, error in
            
            switch error {
            case .some(let error as NSError) where error.code == AuthErrorCode.wrongPassword.rawValue:
                print("wrong Password")
                self?.wrongPassword = true
            case .some(let error as NSError) where error.code == AuthErrorCode.invalidEmail.rawValue:
                print("wrong Email")
                self?.wrongEmail = true
            case .some(let error):
                print("Login error: \(error.localizedDescription)")
                
            case .none:
                if let user = result?.user {
                    self?.wrongPassword = false
                    self?.wrongEmail = false
                    print(user.uid)
                    DispatchQueue.main.async {
                        // success
                        self?.signedIn = true
                    }
                }
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
            
    }
}
