//
//  Question4View.swift
//  Mental Health
//
//
//

import SwiftUI

struct Question4View: View {
    var progress: CGFloat
    @EnvironmentObject var surveyData: SurveyData
    @State private var selectedOption: String?

    let options = [
        ("I withdraw and spend time alone", "ANXIETY DUE TO LIFE CIRCUMSTANCES", 2),
        ("I seek out people who make me feel better", "NEED PEER/SOCIAL SUPPORT SYSTEM", 4),
        ("I procrastinate and put things off", "LOW ENERGY / MOTIVATION", 0),
        ("I take small steps to feel more in control", "STRESS DUE TO ACADEMIC PRESSURE", 0)
    ]

    var body: some View {
        ZStack {
            Color("lavenderColor").ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Text("Let’s get to know you better.")
                    .font(.custom("Alexandria", size: 24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                Text("Answer a couple questions to get started.")
                    .font(.custom("Alexandria", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                Image("QuestionIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)

                VStack(spacing: 5) {
                    Text("How do you respond to feeling overwhelmed?")
                        .font(.custom("Alexandria", size: 18))
                        .bold()
                        .foregroundColor(.black)

                    Text("Select one.")
                        .font(.custom("Alexandria", size: 14))
                        .foregroundColor(.gray)
                }

                ForEach(options, id: \.0) { option in
                    Button(action: {
                        selectedOption = option.0
                    }) {
                        Text(option.0)
                            .font(.custom("Alexandria", size: 16))
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedOption == option.0 ? Color.purple : Color.clear, lineWidth: 2)
                            )
                    }
                }

                NavigationLink(destination: {
                    if let selected = selectedOption,
                       let match = options.first(where: { $0.0 == selected }) {
                        surveyData.addPoints(for: match.1, points: match.2)
                    }
                    return Question5View(progress: progress + 1/7)
                }()) {
                    Image("NextButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 50)
                        .shadow(radius: 4)
                }
                .disabled(selectedOption == nil) // 🚫 disables until user selects


                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(width: 319, height: 14)
                        .foregroundColor(Color(hex: "#C3B9D1"))

                    Capsule()
                        .frame(width: 319 * progress, height: 14)
                        .foregroundColor(Color(hex: "#8F81DC"))
                }
                .cornerRadius(20)
                .padding(.top, 5)
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        Question4View(progress: 4/7)
            .environmentObject(SurveyData())
    }
}
