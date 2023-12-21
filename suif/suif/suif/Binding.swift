import SwiftUI


struct Stepzors: View {
    let title: String
    @Binding var value: Int

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Button("-") { value -= 1 }
            Button("+") { value += 2 }
        }
    }

}

struct BindingView: View {
    @State var count = 0

    var body: some View {
        Text("Count \(count)")
        Stepzors(title: "Beans", value: $count)
          .frame(maxWidth: 200) // , maxHeight: .infinity)
    }
}

#Preview {
    BindingView()
}
