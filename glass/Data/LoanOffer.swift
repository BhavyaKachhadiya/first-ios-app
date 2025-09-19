import Foundation

// A nested struct to handle the 'user' object inside each loan offer
struct User: Codable {
    let id: String
    let username: String
    let userProfile: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, userProfile = "user_profile"
    }
}

// The main struct for each loan offer
struct LoanOffer: Codable, Identifiable {
    let id: String
    let user: User // The nested user struct
    let amount: Int
    let interestRate: Double
    let tenure: Double // This field is named 'loan_term' in the JSON
    
    // Use CodingKeys to map the API's snake_case keys to your camelCase properties
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user, amount, interestRate = "interest_rate"
        case tenure = "loan_term"
    }
}

// The top-level response struct
struct LoanOfferResponse: Codable {
    let loanoffers: [LoanOffer]
    let total: Int
    let totalPages: Int
    let currentPage: Int
    
    enum CodingKeys: String, CodingKey {
        case loanoffers, total, totalPages, currentPage
    }
}
