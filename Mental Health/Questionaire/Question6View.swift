//
//  Question6View.swift
//  Mental Health
//
//
//

import SwiftUI

struct Question6View: View {
    var progress: CGFloat
    @EnvironmentObject var surveyData: SurveyData
    @State private var selectedOption: String?

    let options = [
        ("One-on-one counseling or therapy", "ANXIETY DUE TO LIFE CIRCUMSTANCES", 3),
        ("Talking with friends or peers", "NEED PEER/SOCIAL SUPPORT SYSTEM", 2),
        ("Reading articles or using apps", "LOW ENERGY / MOTIVATION", 0),
        ("Joining a group or attending workshops", "STRESS DUE TO ACADEMIC PRESSURE", 0)
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
                    Text("How do you prefer to get support when you need it?")
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
                    return Question7View(progress: progress + 1/7)
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
        Question6View(progress: 6/7)
            .environmentObject(SurveyData())
    }
}
