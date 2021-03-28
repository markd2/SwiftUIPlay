import UIKit
import SwiftUI


struct PersonFilterView: View {
    var body: some View {
        Text("Snorgle")
    }
}

class PersonFilterViewController: UIHostingController<PersonFilterView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: PersonFilterView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

