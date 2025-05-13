//your avataar ui, notifications, banner add
//add navbar, add shadow below white, add scrollable
//add designer's toggle ui
//need to see firebase schema to connect it to firebase variables
import SwiftUI

struct AccountView: View {
    // Avatar and Personal Info
//    @State private var avatar: Image = Image(systemName: "person.circle")
//    @State private var name: String = storeData.firstName
//    @State private var pronouns: String = "they/she"
//   
//    @State private var email: String = storeData.email
//    @State private var phone: String = storeData.phoneNumber
//
//    @State private var isLightMode: Bool = true
//    @State private var notificationsEnabled: Bool = false
    @State private var avatar: Image = Image(systemName: "person.circle")
    @State private var name: String = "Akshi"
    @State private var pronouns: String = "they/she"
   
    @State private var email: String = "akshi.rajendran@gmail.com"
    @State private var phone: String = "310-259-9385"

    @State private var isLightMode: Bool = true
    @State private var notificationsEnabled: Bool = false
    @State private var retakeQuiz: Bool = false
    @State private var editProfile: Bool = false

    


    

    var body: some View {
        
        ZStack {
          
            
            Color(red: 228/255, green: 225/255, blue: 243/255)
                .edgesIgnoringSafeArea(.all)
           
            
            VStack(spacing: 20) {
                
                VStack {
                    
            
                    ZStack {
                        
                        Image("profile_cow")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
//                            .clipShape(Circle())
//                            .overlay(Circle().stroke(Color.lightblue, lineWidth: 4))
//                            .shadow(radius: 10)
                            .padding(25)
                            .padding(.top, 130)
                        
                        
                        Button(action: {editProfile=true
                        })
                        {
                            Image("edit_profile")
                                .resizable()
                                .foregroundColor(Color.white)
                                .background(Color.lightblue)
                                .clipShape(Circle())
                                .frame(width: 35, height: 35)
                                .offset(x: 70, y: 125)
                                
                        }
                        
                        if(editProfile)
                        {
                            ContentView()
//                            Image("cow")
                        }
                    }
                }
                
                // Personal Info Section
                InfoSection(title: "Personal Info") {
                    VStack(alignment: .leading) {
                        InfoRow(label: "NAME", value: name, action: {
                            print("Edit Name")
                        })
                        InfoRow(label: "PRONOUNS", value: pronouns, action: {
                            print("Edit Pronouns")
                        })
                    }
                }
                
                // Contact Info Section
                InfoSection(title: "Contact Info") {
                    VStack(alignment: .leading) {
                        InfoRow(label: "EMAIL", value: email, action: {
                            print("Edit Email")
                        })
                        InfoRow(label: "PHONE", value: phone, action: {
                            print("Edit Phone")
                        })
                    }
                }
                
                // Preference Info Section
                //link to notif pg?
                InfoSection(title: "Preference Info") {
                    VStack {
                        HStack {
                            // Image("toggleOn")
                            //dark mode colors --> ask designers for dark light purpke and dark dark purple
                           
                            Text("COLOR MODE")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Spacer()
                            Image((isLightMode ? "toggleOn" : "toggleOff"))
                                .onTapGesture {
                                    isLightMode.toggle()
                                }
                            
                            Text(isLightMode ? "LIGHT" : "DARK")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                        .padding(.vertical, 5)
                        
                        HStack {
//                            Image("toggleOff")
                            Text("NOTIFICATIONS")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Spacer()
                            Image(notificationsEnabled ? "toggleOn" : "toggleOff")
                                
                                   .onTapGesture {
                                       notificationsEnabled.toggle()
                                   }

                               Text(notificationsEnabled ? "ON" : "OFF")
                                   .font(.subheadline)
                                   .foregroundColor(.black.opacity(1))
                            
                        }
                        
                    }
                }
                
                // Retake Quiz Section
                VStack(spacing: 20) {
                    Text("Want to redo your Moo’d profile?")
                        .font(.headline)
                    Button(action: {retakeQuiz=true})
                    {
                        Text("RETAKE QUIZ")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 200, maxHeight: 40)
                            .background(Color.darkPurple)
                            .cornerRadius(30)
                    }
                    if retakeQuiz{
                        
                        //replace w quiz view
                        ContentView()

                    }
                    
                }
                .padding(.horizontal)
                
                Spacer()
                //dark purp = 140,129 ,213
                // Implement navbar- current one doesnt show up, its just here to prevent an error
                HStack {
                    NavigationButton(iconName: "house.fill", label: "Home")
                        .frame(maxWidth: .infinity)
                    NavigationButton(iconName: "book.fill", label: "Journal")
                        .frame(maxWidth: .infinity)
                    NavigationButton(iconName: "chart.bar.fill", label: "Stats")
                        .frame(maxWidth: .infinity)
                    NavigationButton(iconName: "gearshape.fill", label: "Settings")
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .frame(height: 60)
                .background(Color.white)
//                .shadow(radius: 10)
            }
            .padding()
            .padding(.bottom, 50)
        }
    }
}




struct InfoSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .bold()
            content
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(label)
                    .font(.caption)
                Text(value)
                    .font(.subheadline)
                    .bold()
            }
            Spacer()
//            Button(action: action) {
//                Image("edit_profile")
//                    .resizable()
//                    .foregroundColor(Color.white)
//                    .background(Color.white)
//                    .clipShape(Circle())
//                    .frame(width: 25, height: 25)
//            }
//            if editProfile{
//                ContentView()
//            }
                
            
        }
    }
}

// Reusable Navigation Button- need to update with new UI
struct NavigationButton: View {
    let iconName: String
    let label: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(Color.white)
            Text(label)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AccountView()
//    ContentView()
}
