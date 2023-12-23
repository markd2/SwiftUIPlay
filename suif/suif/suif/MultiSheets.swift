import SwiftUI

enum Sheet: String, Identifiable {
    case addPerson
    case settings
    
    var id: String { rawValue }
}

struct MultiSheets: View {
    @State var sheetToPresent: Sheet?

    struct AddPersonView: View {
        var body: some View {
            Text("ADD PERSON")
        }
    }

    struct SettingsView: View {
        var body: some View {
            Text("SETTINGS")
        }
    }


    var body: some View {
        VStack {
            Button("Add Person") { sheetToPresent = .addPerson }
            Button("Settings") { sheetToPresent = .settings }
        }
        .sheet(item: $sheetToPresent) { sheet in
            switch sheet {
                case .addPerson: AddPersonView()
                case .settings: SettingsView()
            }
        }
    }
}


#Preview {
    MultiSheets()
}
