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

    init(everyone: [Person]) {
        self.everyone = everyone
        self.results = everyone
        filterTrigger = $filters.sink(receiveCompletion: { status in
                                          print("COMPLETED \(status)")
                                      },
                                      receiveValue: { filters in
                                          print("FILTERS \(filters)")
                                      })

    }
}
