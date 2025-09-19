import SwiftUI

struct SettingsView: View {
    @State private var isNotificationsEnabled = true

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings View")
                .font(.largeTitle)
                .bold()

            Toggle(isOn: $isNotificationsEnabled) {
                Text("Enable Notifications")
                    .foregroundStyle(.primary)
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
