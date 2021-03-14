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
    var body: some View {
        Text("Greeble").background(Color.blue)
        NavigationLink(destination: ViewControllerView()) {
            Text("Flongwaffle")
        }.navigationBarTitle("Navigation")
    }
}

