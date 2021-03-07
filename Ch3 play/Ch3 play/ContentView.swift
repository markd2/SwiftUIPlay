




















import SwiftUI

class DatabaseConnection: ObservableObject {
    var isConnected: Bool = true
}

struct SomeView: View {
    // the database is effectively injected
    @EnvironmentObject var connection: DatabaseConnection

    var body: some View {
        VStack {
            if connection.isConnected {
                Text("Connected")
            } else {
                Text("Not Connected")
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            SomeView()
        }.environmentObject(DatabaseConnection())
    }
}

// ---------- custom environment stuffs

struct ch3_customEnvironment_ContentView: View {
    @State var volume = 0.33
    @State var cutoff = 0.5

    var body: some View {
        HStack {
            VStack {
                ch3_customEnvironment_Knob(value: $volume)
                  .frame(width: 100, height: 100)
                Text("Volume")
            }
            VStack {
                ch3_customEnvironment_Knob(value: $cutoff)
                  .frame(width: 100, height: 100)
                Text("Cutoff")
            }
        }
          .knobPointerSize(0.1) // custom enviroment step 6/6
    }
}

// custom environment step 1/6
fileprivate struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

// custom environment step 2/6
extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get { self[PointerSizeKey.self] }  // since has the type, can get the defaultValue for the  default, I think...
        set { self[PointerSizeKey.self] = newValue }
    }
}

// custom environment step 3/6
extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        environment(\.knobPointerSize, size)
        // environment is a method of self (View)
    }
}

struct ch3_customEnvironment_Knob: View {
    @Binding var value: Double // 0 through 1
    @Environment(\.colorScheme) var colorScheme

    var pointerSize: CGFloat? = nil
    // custom environment step 4/6
    @Environment(\.knobPointerSize) var envPointerSize
    
    var body: some View {
        // custom environment step 5/6
        KnobShape(pointerSize: pointerSize ?? envPointerSize)
          .fill(colorScheme == .dark ? Color.white : Color.black)
          .rotationEffect(Angle(degrees: value * 330))
          .onTapGesture {
              self.value = self.value < 0.5 ? 1 : 0
          }
    }
}

// ----------

struct ch3_3_ContentView: View {
    @State var flunge = 0.33

    var body: some View {
        ch3_3_Knob(value: $flunge).frame(width: 100, height: 100)
        Text("Blah \(flunge)")
        Slider(value: $flunge, in: (0...1))
    }
}


struct ch3_3_Knob: View {
    @Binding var value: Double // 0 through 1
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        KnobShape()
          .fill(colorScheme == .dark ? Color.white : Color.black)
          .rotationEffect(Angle(degrees: value * 330))
          .onTapGesture {
              self.value = self.value < 0.5 ? 1 : 0
          }
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

// ----------

struct ch3_2_ContentView: View {
    var body: some View {
        VStack {
            Text("Text 1")
            HStack {
                Text("Text 2")
                Text("Text 3")
            }.font(.largeTitle)
        }.debug()
    }
}


// ----------
struct ch3_1_ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
              .transformEnvironment(\.font) { dump($0) }
        }
        .font(.headline) // Write the font into the environment
                         // and so pass down (e.g. lexically up) the view tree
		         // so that the Text can read it
        .environment(\.font, Font.headline) // same thing
        .debug()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
