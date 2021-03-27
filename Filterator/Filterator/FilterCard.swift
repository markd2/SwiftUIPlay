import UIKit

protocol FilterCard: AnyObject {
    var editorView: UIView { get }

    // anything not allowed by any filter is hidden
    func allow(_ person: Person) -> Bool

    // let someone know something changed
    var somethingChanged: (() -> (Void))? { get set }
}

