import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = LoanOfferViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.secondary)
                    .preferredColorScheme(colorScheme)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.secondary)
                    .preferredColorScheme(colorScheme)
            } else {
                List(viewModel.offers) { offer in
                    LoanOfferCard(
                        profileImageURL: URL(string: offer.user.userProfile ?? ""),
                        interestRate: offer.interestRate,
                        amount: offer.amount,
                        tenure: offer.tenure,
                        username: offer.user.username
                    )
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .navigationTitle("Loan Offers")
                .preferredColorScheme(colorScheme)
            }
        }
        .onAppear {
            Task {
                await viewModel.loadOffers()
            }
        }
    }
}
