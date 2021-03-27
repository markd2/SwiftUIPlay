import UIKit

class uikitBloodTypeViewController: UIViewController, FilterCard {
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var typeChooser: UISegmentedControl!

    // protocol conformance here, because we can't have `var` in extensions :-(
    var editorView: UIView {
        view
    }
    
    func allow(_ person: Person) -> Bool {
        let index = typeChooser.selectedSegmentIndex
        if index == UISegmentedControl.noSegment {
            return true
        } else {
            let selectedType = Person.BloodType.allCases[index]
            return person.bloodType == selectedType
        }
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
        somethingChanged?()
        updateUI()
    }

    @IBAction func clear() {
        typeChooser.selectedSegmentIndex = UISegmentedControl.noSegment
        somethingChanged?()
        updateUI()
    }
}
