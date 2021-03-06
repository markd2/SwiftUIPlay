import SwiftUI


final class Contact: ObservableObject, Identifiable {
    let id = UUID()

    @Published var name: String
    @Published var city: String

    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
}

let contacts = [
  Contact(name: "Flongwaffle", city: "Leechburg"),
  Contact(name: "Failwaffle", city: "Hamburg"),
  Contact(name: "Dudewaffle", city: "Broburg")
]


struct ContentView: View {
    @State var selection: Contact?

    var body: some View {
        HStack {
            ForEach(contacts) { contact in
                Button(contact.name) { self.selection = contact }
            }
        }
        if let c = selection {
            Detail(contact: c)
        }
    }
}


struct Detail: View {
    @ObservedObject var contact: Contact

    var body: some View {
        VStack {
            Text(contact.name).bold()
            Text(contact.city)
        }
    }
}

// ----------

struct Elegant_Binding_Knob: View {
    @Binding var value: Double // 0 through 1
    
    var body: some View {
        KnobShape().fill(Color.primary)
        .rotationEffect(Angle(degrees: value * 330))
        .onTapGesture {
            self.value = self.value < 0.5 ? 1 : 0
        }.debug()
    }
}

struct Elegant_Binding_ContentView: View {
    @State var volume: Double = 0.5

    var body: some View {
        VStack {
            Elegant_Binding_Knob(value: $volume)
              .frame(width: 100, height: 100)
            Slider(value: $volume, in: (0...1))
        }.debug ()
    }
}

// ----------

struct Inelegant_Binding_Knob: View {
    var value: Double // 0 through 1
    var valueChanged: (Double) -> ()
    
    var body: some View {
        KnobShape().fill(Color.primary)
        .rotationEffect(Angle(degrees: value * 330))
        .onTapGesture {
             self.valueChanged(self.value < 0.5 ? 1 : 0)
        }.debug()
    }
}

struct Inelegant_Binding_ContentView: View {
    @State var volume: Double = 0.5

    var body: some View {
        VStack {
            Inelegant_Binding_Knob(value: volume, valueChanged: { newValue in
                                    self.volume = newValue
                                })
              .frame(width: 100, height: 100)
            Slider(value: $volume, in: (0...1))
        }.debug ()
    }
}

// ----------

struct Chapter_2_5LabelView: View {
    @Binding var number: Int
    var body: some View {
        print("LabelView")
        return Group {
            if number > 0 {
                Text("You've tapped \(number) times")
            }
        }
    }
}

struct Chapter_2_5ContentView: View {
    var counter = State(initialValue: 0)
    var body: some View {
        VStack {
            Button("Snorlg") { self.counter.wrappedValue += 1 }
            Chapter_2_5LabelView(number: counter.projectedValue)
        }
    }
}

// ----------


struct Chapter2_4ContentView: View {
    @State var counter = 0
    var body: some View {
        if counter > 0 {
            Text("Flong")
        }
    }
    @ViewBuilder var bodyx: some View {
        ForEach(1...3, id: \.self) { x in
            Text("Item \(x)")
        }.debug()
        ForEach(["hello", "bork", "splunge"], id: \.self) { x in
            Text("Item \(x)")
        }.debug()
    }
}


// ----------

struct Chapter2_3LabelView: View {
    @Binding var number: Int
    var body: some View {
        print("LabelView")
        return Group {
            if number > 0 {
                Text("You've tapped \(number) times")
            }
        }
    }
}

struct Chapter2_3ContentView: View {
    @State var counter = 0

    var body: some View {
        print("ContentView")
        return VStack {
            Button("Blah") { self.counter += 1 }
            Chapter2_3LabelView(number: $counter)
        }
    }
}

//----------

struct Chapter2_2LabelView: View {
    @State var counter = 0

    var body: some View {
        print("LabelView \(counter)")
        return VStack {
            Button("Tappenzee") { self.counter += 1 }
            if counter > 0 {
                Text("tapped \(counter)")
            }
        }
    }
}

struct Chapter2_2ContentView: View {
    var body: some View {
        print("Content View")
        return Chapter2_2LabelView()
    }
}


// ----------
struct Chapter2LabelView: View {
    let number: Int
    var body: some View {
        print("Label View \(number)")
        return Group {
            if number > 0 {
                Text("Flunge \(number)")
            }
        }.debug()
    }
}

struct Chapter2ContentView: View {
    @State var counter = 0

    var body: some View {
        print("Content")
        return VStack {
            Button("Tappanzee") { self.counter += 1 }
            Chapter2LabelView(number: counter)
        }.debug()
    }
}

// ----------
struct Chapter1ContentView: View {
    @State var counter = 0
    @State var optionalCounter: Int? = 0

    var body: some View {
        VStack {
            Button(action: { counter += 1}, // modifies the struct's property
                   label: {
                       Text("Tappenzee")
                         .padding()
                         .background(Color(.tertiarySystemFill))
                         .cornerRadius(5)
                         })
            if counter == 1 {
                Text("Snarngle waffle")
            } else if counter > 0 {
                Text("You tappped \(counter) times")
            } else {
                Text("No Tappa You")
            }

#if false
            switch counter > 0 {
                case true: Circle()
                case false: Rectangle()
            }

            if let c = optionalCounter {
                Text("\(c)")
            }
            Button(action: {}, label: {
                                   Text("Hi!")
                               })
#endif
        }
//          .frame(width: 200, height: 200) 
//        .border(Color.black)
          .debug()
    }
}

struct BlahView: View {
    @State var counter = 0

    var body: some View {
        VStack {
            Button(action: { counter += 1},
                   label: {
                       Text("Tappenzee")
                         .padding()
                         .background(Color(.tertiarySystemFill))
                         .cornerRadius(5)
                         })
            if counter == 1 {
                Text("Snarngle waffle")
            } else if counter > 0 {
                Text("You tappped \(counter) times")
            } else {
                Text("No Tappa You")
            }
        }
        .debug()
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}


struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1 // these are relative values
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}
