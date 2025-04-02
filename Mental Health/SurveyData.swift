//
//  SurveyData.swift
//  Mental Health
//
//
//


import Foundation
import FirebaseFirestore
import FirebaseAuth

class SurveyData: ObservableObject {
    @Published var scores: [String: Int] = [
        "ANXIETY DUE TO LIFE CIRCUMSTANCES": 0,
        "NEED PEER/SOCIAL SUPPORT SYSTEM": 0,
        "STRESS DUE TO ACADEMIC PRESSURE": 0,
        "LOW ENERGY / MOTIVATION": 0
    ]

    // 🆕 Add user profile fields
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""

    func addPoints(for category: String, points: Int) {
        scores[category, default: 0] += points
    }

    func saveToFirestore() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in.")
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("Users'info").document(userID)

        let userData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": phoneNumber,
            "scores": scores
        ]

        userRef.setData(userData) { error in
            if let error = error {
                print("❌ Error saving to Firestore: \(error.localizedDescription)")
            } else {
                print("✅ Full user data (profile + survey) saved successfully.")
            }
        }
    }
}
