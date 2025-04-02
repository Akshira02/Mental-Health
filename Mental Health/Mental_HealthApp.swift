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
    @StateObject var surveyData = SurveyData()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSplash = false
                        }
                    }
            } else {
                NavigationStack {
                    LoginView()
                }
                .environmentObject(surveyData)
            }
        }
    }
}
