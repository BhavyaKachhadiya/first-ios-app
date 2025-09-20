import SwiftUI
struct HomeView: View {
    @ObservedObject var viewModel: LoanOfferViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.offers) { offer in
                    LoanOfferCard(
                        profileImageURL: URL(string: offer.user.userProfile ?? ""),
                        interestRate: offer.interestRate,
                        amount: offer.amount,
                        tenure: offer.tenure,
                        username: offer.user.username
                    )
                    .listRowSeparator(.hidden)
                    .onAppear {
                        Task {
                            await viewModel.loadNextPageIfNeeded(currentItem: offer)
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .listStyle(.plain)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .navigationTitle("Loan Offers")
            .preferredColorScheme(colorScheme)
            .refreshable {
                Task {
                    // Pull-to-refresh: reload first page only
                    viewModel.currentPage = 1
                    await viewModel.loadOffers()
                }
            }
            .onAppear {
                Task {
                    // Load first page if nothing is loaded yet
                    if viewModel.offers.isEmpty {
                        await viewModel.loadOffers()
                    }
                }
            }
        }
    }
}
