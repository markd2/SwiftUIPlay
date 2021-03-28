import UIKit
import Combine

class cbnViewController: UIViewController {
    var dataGod: DataGod!
    var resultsChange: AnyCancellable!

    func setupChangeObserver() {
        resultsChange = dataGod?.$results.sink { peoples in
            self.setContents(to: peoples)
        }
   }

    func configureFilter(_ filter: cbnFilterCard) {
        filter.dataGod = dataGod
    }


    // Everything below here is (somewhat) common.

    @IBOutlet var editorContainer: UIStackView!

    @IBOutlet var personTableView: UITableView!
    var personDataSource: UITableViewDiffableDataSource<Int, Person>!

    var everyone: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        everyone = Person.random(count: Person.suggestedPersonCount)
        dataGod = DataGod(everyone: everyone)

        personTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Splunge") 

        personDataSource = UITableViewDiffableDataSource(tableView: personTableView) {
            (tableView, indexPath, person) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Splunge", for: indexPath)
            cell.textLabel?.text = person.name + " type " + person.bloodType.rawValue + " size \(person.shoeSize)"
            return cell
        }

        setContents(to: everyone, animated: false)
        setupFilters()
        setupChangeObserver()
    }

    func setContents(to folks: [Person], animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Person>()

        snapshot.appendSections([0])
        snapshot.appendItems(folks, toSection: 0)
        personDataSource.apply(snapshot, animatingDifferences: animated)
    }

    var filters: [cbnFilterCard] = []

    func setupFilters() {
        filters = [
          cbnBloodTypeViewController(),
          cbnNameFilterViewController(),
        ]

        filters.forEach { filter in
            configureFilter(filter)
            editorContainer.addArrangedSubview(filter.editorView)
        }
    }

}
