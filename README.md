# SwiftUIPlay

Notes and experiment dumping ground learning SwiftUI.  Now that I have
a shipping side project that I can drop iOS 12 support, I can actually
learn this stuff for real.

* See my [questions](questions.md) document for raw notes.  I take a lot
  of notes when learning stuff.
* See my [design][design.md] document for design sketches for apps and exercises.

So far, it's notes and observations and exercises from the Objc.io
[Thinking in SwiftUI](https://www.objc.io/books/thinking-in-swiftui/).
It dives in to technical details. Don't expect "This is xcode. This
is the preview. Look, you can change the UI and see the code change (when
it works)" - there's other materials that cover that.  TiS dives right in with
SwiftUI types, interior communication, and low-level "here's how things
happen" details.  (that stuff is totally my Jam)

Like, this little utility was totally worth the price of
admission. Being able to see into the types involved was a major
epiphany.
 
```
extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
```

-----
Underdog Devs - feel free to hit me up on the slack (markd) with questions
or commiseration :-)

