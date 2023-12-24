import SwiftUI

struct CreateCardView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @Environment(\.screamAtMe) var screamAtMe: Bool

    var body: some View {
        Button(screamAtMe ? "CANCEL" : "Cancel") {
            dismiss()
        }
    }
}

#Preview {
    CreateCardView()
}
