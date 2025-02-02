import SwiftUI

class SharedData: ObservableObject {
    @Published var name: String = "AC"
    @Published var email: String = "test05@gmail.com"
    @Published var phone: String = "000-000-0000"
    @Published var pronouns: String = "he/him"
    @Published var mode = true
    @Published var topColor: Color = Color("purple")
    @Published var buttoncolor: Color = Color("rightblue")
    @Published var textColor: Color = Color.black
    @Published var lighttext: Color = Color("peach")
    @Published var titleColor: Color = Color.black
    @Published var navbarColor: Color = Color("peach")
}

struct ContentView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        NavigationStack {
            ZStack {
                sharedData.topColor
                    .ignoresSafeArea()
                
                VStack {
                    Button("Change Mode") {
                        sharedData.mode.toggle()
                        if sharedData.mode {
                            sharedData.topColor = Color("purple")
                            sharedData.titleColor = .black
                        } else {
                            sharedData.topColor = .black
                            sharedData.titleColor = .white
                        }
                    }
                    .padding(.top, 50)
                    .foregroundColor(sharedData.titleColor)
                    
                    Spacer()
                    
                    // Navigation Bar
                    homebar()
                        .environmentObject(sharedData)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct homebar: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        HStack {
            NavigationLink(destination: Dashboard()) {
                Image(systemName: "house")
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .scaleEffect(2)
            }
            
            NavigationLink(destination: QuestionaireView()) {
                Image(systemName: "book")
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .scaleEffect(2)
            }
            
            NavigationLink(destination: ResourceView()) {
                Image(systemName: "doc.text")
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .scaleEffect(2)
            }
            
            NavigationLink(destination: ContentView().environmentObject(sharedData)) {
                Image(systemName: "gear")
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .scaleEffect(2)
            }
        }
        .padding()
        .background(sharedData.navbarColor)
        .cornerRadius(20)
        .frame(width: 350, height: 100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SharedData())
    }
}
