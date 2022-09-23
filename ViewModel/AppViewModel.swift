import SwiftUI
import Firebase

class AppViewModel: ObservableObject {
    
    var auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signout() {
        do {
            try auth.signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self]
            result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                // success
                self?.signedIn = true
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
