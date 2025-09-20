import SwiftUI

struct ContentView: View {
    @StateObject private var loanOfferVM = LoanOfferViewModel()

    var body: some View {
        TabView {
            HomeView(viewModel: loanOfferVM)
                .tabItem { Label("Home", systemImage: "house") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}


#Preview {
    ContentView()
}
