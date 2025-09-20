import Foundation

class LoanOfferService {
    func fetchLoanOffers(page: Int, limit: Int = 6) async throws -> LoanOfferResponse {
        let urlString = "https://dsu-project.vercel.app/api/loan/loanoffer?page=\(page)&limit=\(limit)&minInterestRate=6&maxInterestRate=15&minAmount=1000&maxAmount=100000&minTenure=1&maxTenure=7"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(LoanOfferResponse.self, from: data)
        return decodedResponse
    }
}
