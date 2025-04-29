//
//  RewardView.swift
//  Landmarks
//
//  Created by Akshitha Rajendran on 4/29/25.
//
import SwiftUI

struct RewardView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.lightpeach, Color.lightPurple]),
                startPoint: .top,
                endPoint: .bottom
            )
            VStack(spacing: 20) {
                Image("reward_cow")
                //resize???
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .padding(.top,50)
                Text("Thanks for checking in! You’ve earned 30 points.")
                    .font(.subheadline)
                    .foregroundColor(.black)
                Button(action: {
                    print("Return Home")
                        
                }) {
                    Text("Return Home")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200, maxHeight: 40)
                        .background(Color.darkPurple)
                        .cornerRadius(30)
                        .padding(.bottom,200)
                    
                }
                     
            }
        }
    }
}
#Preview
{
    RewardView()
}
