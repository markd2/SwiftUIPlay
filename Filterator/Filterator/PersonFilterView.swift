import UIKit
import SwiftUI

struct PersonFilterView: View {
    @State var people = Person.random(count: Person.suggestedPersonCount)
//    @State var dataGod: DataGod

    var body: some View {
        Text("Snorgle \(people.count)")
        List {
//            BloodTypeEditor(bloodTypeFilter: $dataGod.filters.bloodType)
            ForEach(people, id: \.self) { person in
                HStack {
                    return Text(person.name + " type " + person.bloodType.rawValue + " size \(person.shoeSize)")
                }
            }
        }
    }
}

struct BloodTypeEditor: View {

    @Binding var bloodTypeFilter: Person.BloodType

    var body: some View {
        HStack {
            Text("oop")
            Text("ack")
        }
    }
}




// ----------
// Shim to work inside of a storyboard

class PersonFilterViewController: UIHostingController<PersonFilterView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: PersonFilterView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

