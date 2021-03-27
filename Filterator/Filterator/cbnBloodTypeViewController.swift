import UIKit

class cbnBloodTypeViewController: UIViewController, cbnFilterCard {
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var typeChooser: UISegmentedControl!

    // protocol conformance here, because we can't have `var` in extensions :-(
    var editorView: UIView {
        view
    }
    var somethingChanged: (() -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        // only show clear button if a segment is highlighted
        clearButton.isHidden = typeChooser.selectedSegmentIndex == UISegmentedControl.noSegment
    }

    @IBAction func changed(seggie: UISegmentedControl) {
        updateUI()
    }

    @IBAction func clear() {
        typeChooser.selectedSegmentIndex = UISegmentedControl.noSegment
        updateUI()
    }
}
