




















import SwiftUI


struct ContentView: View {
    @State var flunge = 0.33

    var body: some View {
        Knob(value: $flunge).frame(width: 100, height: 100)
        Text("Blah \(flunge)")
        Slider(value: $flunge, in: (0...1))
    }
}


struct Knob: View {
    @Binding var value: Double // 0 through 1
    @Environment(\.colorScheme) var colorScheme

    var pointerSize: CGFloat = 0.1  // e.g. 32 bits :-D
    
    var body: some View {
        KnobShape(pointerSize: pointerSize * 2)
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
