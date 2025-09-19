import SwiftUI

struct LoanOfferCard: View {
    var profileImageURL: URL?
    var interestRate: Double
    var amount: Int
    var tenure: Double
    var username: String
    
    @State private var isExpanded: Bool = false
    @Namespace private var namespace

    var body: some View {
        Button(action: {
            // This action will be triggered when the card is tapped
            // For now, it just toggles the isExpanded state
            withAnimation(.spring()) {
                isExpanded.toggle()
            }
        }) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    AsyncImage(url: profileImageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 50, height: 50)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                        case .failure:
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.secondary)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text(username)
                        .font(.headline)
                        .bold()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Interest Rate")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("\(String(format: "%.2f", interestRate))%")
                            .font(.headline)
                            .fontWeight(.heavy)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Amount")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("₹\(amount)")
                            .font(.headline)
                            .fontWeight(.heavy)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Tenure")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("\(String(format: "%.1f", tenure)) Years")
                            .font(.headline)
                            .fontWeight(.heavy)
                    }
                }
                .padding(.top, 5)
            }
            .padding()
            // Applying .buttonStyle(.glass) to the button itself
        }
        .buttonStyle(.glass)
        .buttonBorderShape(.roundedRectangle(radius: 10))
        .padding(.horizontal)
    }
}
