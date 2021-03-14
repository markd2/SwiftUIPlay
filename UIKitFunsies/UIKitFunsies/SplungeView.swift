import SwiftUI

struct ViewControllerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        print("SNORGLE MAKE VC")
        return vc
    }

    func updateUIViewController(_ uiViewController: ViewController,
                                context: Context) {
        print("SNORGLE UPDATE VC")
    }

    typealias UIViewControllerType = ViewController
}

struct SplungeView: View {
    @State private var isSplunging = true

    var body: some View {
        VStack {
            Text("Greeble").background(Color.blue)
            NavigationLink(destination: ViewControllerView()) {
                Text("Flongwaffle")
            }.navigationBarTitle("Navigation")
            Toggle("Snorkle", isOn: $isSplunging)
            Button(action: {
                isSplunging.toggle()
            }) {
                Image(systemName: "tortoise")
            }
            Button(action: {
                       withAnimation(.easeInOut(duration: 1)) {
                           isSplunging.toggle()
                       }
            }) {
                Image(systemName: "pause.circle")
            }
            .padding()
            Image(systemName: "tortoise").scaleEffect(isSplunging ? 0.5 : 2.5)
        }
        .background(isSplunging ? Color.gray : Color.orange)
    }
}

