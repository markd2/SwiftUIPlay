import UIKit

class cbnNameFilterViewController: UIViewController, cbnFilterCard {
    var dataGod: DataGod?
    
    @IBOutlet var textfield: UITextField!

    var editorView: UIView { view }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func textFieldChanged() {
        dataGod?.filters.name = (textfield.text?.isEmpty == true) ? nil : textfield.text
    }

}
