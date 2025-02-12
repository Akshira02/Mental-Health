//
//  Mental_HealthApp.swift
//  Mental Health
//
//  Created by Ashwin Charles on 2/1/25.
//

import SwiftUI
import Firebase

@main
struct Mental_HealthApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
