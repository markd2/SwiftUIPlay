import UIKit

class cbnBloodTypeViewController: UIViewController, cbnFilterCard {
    var dataGod: DataGod?

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

    func handleSelectionChange(index: Int) {
        if index == UISegmentedControl.noSegment {
            dataGod?.filters.bloodType = nil
        } else {
            dataGod?.filters.bloodType = Person.BloodType.allCases[index]
        }
    }

    @IBAction func changed(seggie: UISegmentedControl) {
        updateUI()
        handleSelectionChange(index: typeChooser.selectedSegmentIndex)
    }

    @IBAction func clear() {
        updateUI()
        typeChooser.selectedSegmentIndex = UISegmentedControl.noSegment
        handleSelectionChange(index: typeChooser.selectedSegmentIndex)
    }
}
