import SwiftUI


struct SheetView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        VStack {
            Text("Snorgle")
            Text("Bork")
            Button("Dismiss") {
                dismiss()
            }
        }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(.purple)
    }
}

struct HolySheets: View {
    @State var isSheetPresented = false
    @Environment(\.calendar) var calendar: Calendar

    var body: some View {
        Button("Present Sheet") {
            isSheetPresented = true
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetView()
        }

        if calendar.isDateInWeekend(Date.now) {
            Image(systemName: "hand.thumbsup")
        } else {
            Image(systemName: "hand.thumbsdown")
        }
    }
}

#Preview {
    HolySheets()
}
