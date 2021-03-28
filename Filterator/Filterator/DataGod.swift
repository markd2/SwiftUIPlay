import Foundation
import Combine


/// Name courtesy of a fellow nerd.
class DataGod {
    var everyone: [Person]
    @Published var results: [Person]

    struct Filters {
        var bloodType: Person.BloodType? = nil
        var name: String? = nil
    }
    @Published var filters = Filters()
    var filterTrigger: AnyCancellable!

    func update() {
        results = everyone
    }

    func applyFilters(_ filters: Filters) {
        let filtered = everyone.filter { person in
            var allow = true

            if let bloodType = filters.bloodType {
                if person.bloodType != bloodType {
                    allow = false
                }
            }

            if let name = filters.name {
                if let _ = person.name.range(of: name, options: .caseInsensitive) {
                } else {
                    allow = false
                }
            }

            return allow
        }
        results = filtered
    }

    init(everyone: [Person]) {
        self.everyone = everyone
        self.results = everyone

        // could easily add things like .debounce if the typing got too fast vs
        // processing time.
        filterTrigger = $filters.sink { filters in
            self.applyFilters(filters)
        }
    }
}
