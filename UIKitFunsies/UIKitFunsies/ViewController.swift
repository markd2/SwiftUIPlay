import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func splunge() {
        let splungeView = SplungeView()
        let vc = UIHostingController(rootView: splungeView)
        navigationController?.pushViewController(vc, animated: true)
    }
}

