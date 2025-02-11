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
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Button(action: {userLogin(email: email, password: password)}) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
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

