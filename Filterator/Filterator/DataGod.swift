import Foundation
import Combine

class DataGod {
    var everyone: [Person]
    @Published var results: [Person]

    struct Filters {
        var bloodType: Person.BloodType? = nil
        var name: String? = nil
    }
    var filters = Filters()

    func update() {
        results = everyone
    }

    init(everyone: [Person]) {
        self.everyone = everyone
        self.results = everyone
    }
}
