import Foundation
import Combine
class LoanOfferViewModel: ObservableObject {
    @Published var offers: [LoanOffer] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = LoanOfferService()

    @MainActor
    func loadOffers() async {
        isLoading = true
        errorMessage = nil

        do {
            self.offers = try await service.fetchLoanOffers()
            isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
