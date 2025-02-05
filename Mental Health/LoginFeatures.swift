//
//  LoginFeatures.swift
//  Mental Health
//
//  Created by Nolan Ching on 2/2/25.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

func userSignUp(email: String, password: String){
    Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
        if let error = error {
            print("Error signing up: \(error.localizedDescription)")
            return
        }
        print("User signed up sucessfully: \(result?.user.uid ?? "")")
    }
}

func userLogin(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        if let error = error {
            print("Error logging in: \(error.localizedDescription)")
            return
        }
        print("User logged in sucessfully: \(result?.user.uid ?? "")")
    }
}

func googleLogin() {
    
}


func userLogout() {
    if GIDSignIn.sharedInstance.hasPreviousSignIn(){
        GIDSignIn.sharedInstance.signOut()
        print("User logged out sucessfully.")
        return
    }
    do {
        try Auth.auth().signOut()
        print("User logged out successfully.")
    } catch let signOutError {
        print("Error signing out: \(signOutError.localizedDescription)")
    }
}
