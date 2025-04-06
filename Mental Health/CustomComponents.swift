//
//  CustomComponents.swift
//  Mental Health



import SwiftUI

struct customTextField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        TextField(title, text: $text)
            .padding()
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .foregroundColor(.black)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1))
    }
}

struct customSecureField: View {
    var title: String
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isPasswordVisible {
                    TextField(title, text: $text)
                        .textContentType(.password)
                } else {
                    SecureField(title, text: $text)
                        .textContentType(.password)
                }
            }
            .padding()
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .foregroundColor(.black)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1))

            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
                    .padding(.trailing, 12)
            }
        }
    }
}

struct customButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Alexandrida", size: 18))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal, 40)
    }
}
