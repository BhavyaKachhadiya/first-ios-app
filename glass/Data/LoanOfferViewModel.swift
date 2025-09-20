import Foundation
import Combine
@MainActor
class LoanOfferViewModel: ObservableObject {
    @Published var offers: [LoanOffer] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var currentPage = 1
    @Published var totalPages = 1

    private let service = LoanOfferService()
    private var isLoadingPage = false

    func loadOffers(page: Int? = nil, append: Bool = false) async {
        guard !isLoadingPage else { return }
        isLoadingPage = true
        isLoading = true
        errorMessage = nil

        let pageToLoad = page ?? currentPage

        do {
            let response = try await service.fetchLoanOffers(page: pageToLoad)
            if append {
                self.offers.append(contentsOf: response.loanoffers)
            } else {
                self.offers = response.loanoffers
            }
            self.currentPage = response.currentPage
            self.totalPages = response.totalPages
        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
        isLoadingPage = false
    }

    func loadNextPageIfNeeded(currentItem item: LoanOffer) async {
        guard currentPage < totalPages else { return }

        let thresholdIndex = offers.index(offers.endIndex, offsetBy: -2)
        if let itemIndex = offers.firstIndex(where: { $0.id == item.id }),
           itemIndex >= thresholdIndex {
            await loadOffers(page: currentPage + 1, append: true)
        }
    }
}
