//
//  SurveyData.swift
//  Mental Health
//
//
//


import Foundation

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
}

