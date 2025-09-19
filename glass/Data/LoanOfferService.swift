import Foundation

class LoanOfferService {
    func fetchLoanOffers() async throws -> [LoanOffer] {
        let urlString = "https://dsu-project.vercel.app/api/loan/loanoffer?page=1&limit=6&minInterestRate=6&maxInterestRate=15&minAmount=1000&maxAmount=100000&minTenure=1&maxTenure=7"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(LoanOfferResponse.self, from: data)
            return decodedResponse.loanoffers
        } catch {
            print("Failed to decode or fetch data: \(error.localizedDescription)")
            throw error
        }
    }
}
