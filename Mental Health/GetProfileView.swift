//
//  GetProfileView.swift
//  Mental Health
//

import SwiftUI

struct GetProfileView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var errorMessage: String?
    @State private var isProfileSaved: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("lavenderColor")
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()

                    Image("loginIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)

                    Text("Complete Your Profile")
                        .font(.custom("Alexandria", size: 24))
                        .foregroundColor(.black)

                    customTextField(title: "First Name *", text: $firstName)
                    customTextField(title: "Last Name *", text: $lastName)
                    customTextField(title: "Phone Number *", text: $phoneNumber)

                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }

                    // Save Profile Button with Imagex
                    Button(action: {
                        saveProfile()
                    }) {
                        Image("SaveButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 4)
                    }
                    .padding(.top, 10)

                    NavigationLink(destination: SignUpView()) {
                        Text("Go Back to Sign Up")
                            .font(.custom("Alexandria", size: 16))
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .navigationDestination(isPresented: $isProfileSaved) {
                Question1View(progress: 0.1) // Starting progress at 20%
            }
        }
    }

    func saveProfile() {
        if firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty {
            errorMessage = "All fields are required."
        } else {
            isProfileSaved = true
        }
    }
}


struct GetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GetProfileView()
    }
}
