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
    @State private var showSplash = true

    init() {
        // Configure Firebase if you're using it
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            // Decide which view to show
            if showSplash {
                SplashView()
                    .onAppear {
                        // Hide splash after 2 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSplash = false
                        }
                    }
            } else {
                // After the splash, go to LoginView
                NavigationStack {
                    LoginView()
                }
            }
        }
    }
}


