import UIKit

class cbnNameFilterViewController: UIViewController, cbnFilterCard {
    @IBOutlet var textfield: UITextField!

    var editorView: UIView { view }
    var somethingChanged: (() -> (Void))?
    
    func allow(_ person: Person) -> Bool {
        guard let text = textfield.text, !text.isEmpty else {
            return true
        }

        if let _ = person.name.range(of: text, options: .caseInsensitive) {
            return true
        }
        return false
    }



    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func textFieldChanged() {
        somethingChanged?()
    }

}
