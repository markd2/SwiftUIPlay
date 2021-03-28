//
//  ViewController.swift
//  Filterator
//
//  Created by Mark Dalrymple on 3/27/21.
//

import UIKit

class uikitViewController: UIViewController {

    func redoFiltering() {
        let filtered = everyone.filter { person in
            var allowed = true
            filters.forEach { filter in
                allowed = allowed && filter.allow(person)
            }
            return allowed
        }
        setContents(to: filtered)
    }

    func configureFilter(_ filter: uikitFilterCard) {
        filter.somethingChanged = redoFiltering
    }


    @IBOutlet var editorContainer: UIStackView!

    @IBOutlet var personTableView: UITableView!
    var personDataSource: UITableViewDiffableDataSource<Int, Person>!

    var everyone: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        everyone = Person.random(count: Person.suggestedPersonCount)

        personTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Splunge") 

        personDataSource = UITableViewDiffableDataSource(tableView: personTableView) {
            (tableView, indexPath, person) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Splunge", for: indexPath)
            cell.textLabel?.text = person.name + " type " + person.bloodType.rawValue + " size \(person.shoeSize)"
            return cell
        }

        setContents(to: everyone, animated: false)
        setupFilters()
    }

    func setContents(to folks: [Person], animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Person>()

        snapshot.appendSections([0])
        snapshot.appendItems(folks, toSection: 0)
        personDataSource.apply(snapshot, animatingDifferences: animated)
    }

    var filters: [uikitFilterCard] = []

    func setupFilters() {
        filters = [
          uikitBloodTypeViewController(),
          uikitNameFilterViewController(),
        ]

        filters.forEach { filter in
            configureFilter(filter)
            editorContainer.addArrangedSubview(filter.editorView)
        }
    }

}

