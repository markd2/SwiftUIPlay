










import SwiftUI



struct ContentView: View {
    let image = Image(systemName: "tortoise")
    @State var knobValue: Double = 0.3

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
//                          Text("Fnord Blorkle").frame(width: 100)
//                          Knob(value: $knobValue).resizable()
//                          Knob(value: $knobValue).fixedSize()
//                          Text("Snorgle").background(Capsule().stroke()
//                                                       .padding(-5))

//                          Text("Snorgle").foregroundColor(.white)
//                            .background(Circle().fill(Color.purple))
                        // vs
//                                Circle().fill(Color.blue)
//                                  .overlay(Text("Start").foregroundColor(.white))
//                                  .frame(width: 75, height: 75)
//                          HStack {
//                              Circle().fill(Color.red)
//                              Circle().fill(Color.orange).offset(y: -30)
//                              Circle().fill (Color.purple)
//                          }
//                          MatchedGeometrySample()
//                          Rectangle().rotation(.degrees(33)).fill(Color.red).border(Color.blue).clipped().frame(width:100, height: 100)

//                          HStack {
//                              Text("Snorgle Blorgle")
//                              Rectangle().fill(Color.purple).frame(minWidth: 200)
//                          }

//                          HStack(spacing: 0) {  // this is also very cool
//                              Text("/a/very/long/long/path/blah/blah/")
//                                .truncationMode(.middle).lineLimit(1)
//                              Text("chappter1.md").layoutPriority(1)
//                          }

//                          HStack(spacing: 0) {
//                              Rectangle().fill(Color.purple).frame(minWidth: 50)
//                               Rectangle().fill(Color.orange).frame(maxWidth: 100)
//                                .layoutPriority(1)
//                          }.frame(width: 75)

//                          HStack(alignment: .blahCenter) {
//                              Rectangle().fill(Color.blue).frame(width: 50, height: 70)
//                              Rectangle().fill(Color.yellow).frame(width: 30, height: 40)
//                          }

//                          HStack(alignment: .blahCenter) {
//                              Rectangle().fill(Color.blue).frame(width: 50, height: 70)
//                              Rectangle().fill(Color.purple).frame(width: 30, height: 40)
//                              Rectangle().fill(Color.orange)
//                                .frame(width: 20, height: 45)
//                   // this doesn't work - tried HorizontaAlignment and VerticalAlignment
////                                .alignmentGuide(HorizontalAlignment.center, computeValue: { viewDimensions in
////                                    return viewDimensions[HorizontalAlignment.center] + 90
////                                })
//                   // but this does
//                                .alignmentGuide(.blahCenter, computeValue: { viewDimensions in
//                                    return viewDimensions[.blahCenter] + 90
//                                })
//                          }

       // still doesn't work
//                          HStack(alignment: .center) {
//                              Rectangle().fill(Color.blue).frame(width: 50, height: 70)
//                              Rectangle().fill(Color.purple).frame(width: 30, height: 40)
//                              Rectangle().fill(Color.orange)
//                                .frame(width: 20, height: 45)
//                                .alignmentGuide(HorizontalAlignment.center, computeValue: { viewDimensions in
//                                    return viewDimensions[HorizontalAlignment.center] + 90
//                                })
//                          }

        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
            ForEach(0 ..< 30) { index in
                Text("\(index)").background(Color.orange).frame(height: 50).border(Color.black)
            }
        }
        .frame(width: 400)
        

        ).padding()

        }
}


// Custom alignment guide part 1/2
enum BlahCenterID: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        return context.height / 3
    }
}

// Custom alignment guide part 2/2
extension VerticalAlignment {
    static let blahCenter: VerticalAlignment = VerticalAlignment(BlahCenterID.self)
}


struct MatchedGeometrySample: View {
    @Namespace var ns
    
    var body: some View {
        HStack {
            // causes to overlap
            Rectangle()
              .fill(Color.black)
              .frame(width: 100, height: 100)
              .matchedGeometryEffect(id: "ID", in: ns, isSource: true)
            Circle()
              .fill(Color.gray)
              .matchedGeometryEffect(id: "ID", in: ns, isSource: false)
              .border(Color.green)
        }
        .frame(width: 300, height: 100)
        .border(Color.red)
    }
}

struct Knob: View {
    @Binding var value: Double // 0 through 1
    
    var body: some View {
        KnobShape()
          .frame(width: 32, height: 32)
          .rotationEffect(Angle(degrees: value * 330))
          .onTapGesture {
              self.value = self.value < 0.5 ? 1 : 0
          }
    }

    func resizable() -> some View {
        KnobShape().aspectRatio(1, contentMode: .fit)
          .frame(idealWidth: 32, idealHeight: 32)

          .rotationEffect(Angle(degrees: value * 330))
          .onTapGesture {
              self.value = self.value < 0.5 ? 1 : 0
          }
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
            Spacer()
            content
              .border(Color.gray) // draw a border around the view
              .frame(width: width, height: height)
              .border(Color.black)  // draw one around the frame
            Spacer()
            HStack {
                VStack {
                    Text("frame width")
                    Slider(value: $width, in: 0...500)
                }
                VStack {
                    Text("frame height")
                    Slider(value: $height, in: 0...200)
                }
            }
            VStack {
                Text("gray: content view border")
                Text("black: frame")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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


extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
