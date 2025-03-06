//
//  LoginView.swift
//  Mental Health
//
//  Created by Nolan Ching on 2/7/25.
//
import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .frame(maxWidth: 300)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: {userLogin(email: email, password: password)}) {
                    Text("Login")
                        .frame(maxWidth: 300)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {googleLogin()}) {
                    Text("Sign in with Google")
                        .frame(maxWidth: 300)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                .padding()
                NavigationLink(destination: ProfileView(), isActive: $isLoggedIn){
                    EmptyView()
                }
            }
        }
    }
    

    func userLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error logging in: \(error.localizedDescription)")
                return
            }
            isLoggedIn = true
        }
    }

    func googleLogin() {
        // 1. Get client ID from Firebase config
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("No client ID found in Firebase config.")
            return
        }
        
        // 2. Create Google Sign-In configuration object
        let config = GIDConfiguration(clientID: clientID)
        
        // 3. Get the top-most view controller
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Could not find root view controller.")
            return
        }
        
        // 4. Assign the configuration to the shared instance
        GIDSignIn.sharedInstance.configuration = config
        
        // 5. Start the sign-in flow
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            // 6. Retrieve the tokens
            guard let signInResult = signInResult else {
                print("No sign-in result returned.")
                return
            }
            let user = signInResult.user
            
            guard let idToken = user.idToken?.tokenString else {
                print("Missing ID token")
                return
            }
            let accessToken = user.accessToken.tokenString
            
            // 7. Create a Firebase credential
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: accessToken)
            
            // 8. Sign in to Firebase
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign in error: \(error.localizedDescription)")
                    return
                }
                
                // Success! Navigate or set isLoggedIn = true, etc.
                print("User signed in with Google and Firebase!")
                isLoggedIn = true
            }
        }
    }



    func userLogout() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            GIDSignIn.sharedInstance.signOut()
            isLoggedIn = false
            print("User logged out sucessfully.")
            return
        }
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            print("User logged out successfully.")
        } catch let signOutError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }

}

