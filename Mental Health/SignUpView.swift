//
//  SignUpView.swift
//  Mental Health
//
//  Created by Nolan Ching on 2/11/25.
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

let db = Firestore.firestore()

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var errorMessage: String?
    @State private var isSignedUp: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
                
                
                Button(action: {
                    userSignUp(email: email, password: password, name: name) { success in
                        if success {
                            isSignedUp = true
                        }
                    }
                }){
                    Text("Sign Up!")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            NavigationLink(destination: ProfileView(), isActive: $isSignedUp){
                EmptyView()
            }
            .hidden()
        }
    }
    func saveUserInDB(uid: String, email: String, name: String, completion: @escaping(Bool)->Void){
        let userData: [String: Any] = ["uid": uid, "email": email, "name": name]
        
        db.collection("users").document(uid).setData(userData) {
            error in
            if let error = error {
                print("Error writing document: \(error)")
                completion(false)
            } else {
                print("Document successfully written!")
                completion(true)
            }
        }
    }
    
    func userSignUp(email:String, password:String, name:String, completion: @escaping(Bool)->Void){
        Auth.auth().createUser(withEmail: email, password: password){ (authResult, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
                return
            }
            
            guard let user = authResult?.user else {
                completion(false)
                return
            }
            saveUserInDB(uid: user.uid, email: email, name: name, completion: completion)
        }
    }
}
