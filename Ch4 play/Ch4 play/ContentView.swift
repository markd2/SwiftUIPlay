










import SwiftUI

struct ContentView: View {
    let image = Image(systemName: "tortoise")
    var body: some View {
        MeasureBehavior(content: 
//                          Text("Hello, world!")
//                          PathView()
//                          PathShape()
//                          Triangle().rotation(.degrees(45))
//                          Rectangle().rotation(.degrees(33)).fill(Color.red).border(Color.blue).frame(width:100, height: 100).debug()

//                          HStack {  // this is tremendously cool
//                              image
//                              image.resizable()
//                              image.resizable().aspectRatio(contentMode: .fit)
//                          }

                          .padding()
        )
        }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addLines([
                CGPoint(x: rect.maxX, y: rect.maxY),
                CGPoint(x: rect.minX, y: rect.maxY),
                CGPoint(x: rect.midX, y: rect.minY)
            ])
        }
    }
}

struct PathShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 50, y: 50))
            path.addLines([
                            CGPoint(x: 100, y: 75),
                            CGPoint(x: 0, y: 75),
                            CGPoint(x: 50, y: 0)
                          ])
            }
    }
}

struct PathView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 50, y: 50))
            path.addLines([
                            CGPoint(x: 100, y: 75),
                            CGPoint(x: 0, y: 75),
                            CGPoint(x: 50, y: 0)
                          ])
            }
    }
}

struct MeasureBehavior<Content: View>: View {
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100
    var content: Content

    var body: some View {
        VStack {
            content
              .border(Color.gray) // draw a border around the view
            .frame(width: width, height: height)
            .border(Color.black)  // draw one around the frame
            Slider(value: $width, in: 0...500)
            Slider(value: $height, in: 0...200)
        }
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
