import SwiftUI

struct SnackSizing: View {
    var body: some View {
        // say have 400 horizontal to use
        HStack(spacing: 20) {  // gives 380
            Ellipse().fill(.mint)  // initial land grant: 190
            Text("Splunge Monkey") // initial land grant: 190
              .font(.system(size: 24))
            // which is least flexible?  the ellipse has
            // potential size of 0..infinity.  The text though
            // has a width of say 100.  That 100 is used
            // for the text, and the rest given to the ellipse
        }
    }
}

#Preview {
    SnackSizing()
}
