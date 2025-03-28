//
//  Question2View.swift
//  Mental Health
//
//
//


import SwiftUI

struct Question2View: View {
    var progress: CGFloat
    @EnvironmentObject var surveyData: SurveyData
    @State private var selectedOption: String?

    let options = [
        ("Mentally drained and emotionally overwhelmed", "ANXIETY DUE TO LIFE CIRCUMSTANCES", 4),
        ("Physically tired but emotionally fine", "LOW ENERGY / MOTIVATION", 1),
        ("Anxious about what’s next", "NEED PEER/SOCIAL SUPPORT SYSTEM", 2),
        ("Content and relaxed", "STRESS DUE TO ACADEMIC PRESSURE", 0)
    ]

    var body: some View {
        ZStack {
            Color("lavenderColor").ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()

                Text("How do you usually feel at the end of the day?")
                    .font(.custom("Alexandria", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

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



//                NavigationLink(destination: Question3View(progress: progress + 0.2).environmentObject(surveyData), isActive: .constant(selectedOption != nil)) {
//                    Image("NextButton")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 160, height: 50)
//                        .shadow(radius: 4)
//                }
                .simultaneousGesture(TapGesture().onEnded {
                    if let selected = selectedOption,
                       let match = options.first(where: { $0.0 == selected }) {
                        surveyData.addPoints(for: match.1, points: match.2)
                    }
                })

                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "#8F81DC")))
                    .frame(width: 319)
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        Question2View(progress: 0.4)
            .environmentObject(SurveyData())
    }
}

