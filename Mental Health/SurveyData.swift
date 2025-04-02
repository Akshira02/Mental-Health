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

    func addPoints(for category: String, points: Int) {
        scores[category, default: 0] += points
    }

    // ✅ NEW: Save scores to Firebase Firestore
    func saveToFirestore() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in.")
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("survey_results").document(userID)

        userRef.setData(["scores": scores]) { error in
            if let error = error {
                print("❌ Error saving to Firestore: \(error.localizedDescription)")
            } else {
                print("✅ Survey scores successfully saved to Firestore.")
            }
        }
    }
}

