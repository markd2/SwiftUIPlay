
# random notes

* resume _Thinking in SwiftUI_ at Chapter 4, Layout - Grid Views

* [ ] need to pick up chapter 2 video at 30:34. Managed to get through the
      base exercise and want to move on, but looks like more good stuff in
      there.

==================================================
# accumulated questions

* [ ] what is `some`?
    - "whatever the exact type of the body might be, it definitely conforms
       to the View protocol"
    - why not just "View" ?
    - From a chat with MikeyW - this is a manual optimization so that the
      View protocol type won't generate an existential for each particular 
      `body` and have to do boxing/unboxing of it, like Generics give us.
* [ ] deeper into function builders
    - cannot write loops and guards
    - can write switch and if statements to construct a view tree dependent
      on the app's current state (like the `counter` variable)
    - can write any kind of _expression_ that returns a View, there are only
      a few _statements_  you can write.  e.g. let, case let, and switch
* [ ] what all is in RandomAccessCollection (via ForEach)
    - "efficient random-access index traversal"
    - can move indices any distance and measure distance in O(1) time
    -  adds constraints on assciated Indices and SubSequence types
    - otherwise no additional requirements over BidirectionalCollection
    - in reality, the index must conform to Strideable or implement
      index(_:offsetBy:) and distance(from:to:) in O(1)
    - rabbithole continues down into BidirectionalCollection, Collection, etc
* [ ] Why didn't having a UIImage as a @State in the PhotoView, and assigning
      that image in a network callback work (triggering a refresh of the
      world).
* [ ] overriding alignment guide via computeValue: only with custom layout guides?
      (example in chapter 4 works great with a custom layout guide, didn't have an effect
      when using VerticalAlignment.center)

==================================================
# Property Wrappers seen

* [ ] @State
* [ ] @Binding
* [ ] @ViewBuilder
      - xcode12, the `view` of a View is automatically inferred to be this
        unless there's an explicit return statement
* [ ] @ObservedObject
* [ ] @Published
* [ ] @StateObject
* [ ] @EnvironmentObject
* [ ] @GestureState
* [ ] @Environment
* [ ] @Namespace

c.f. https://developer.apple.com/documentation/swiftui/dynamicproperty#relationships

==================================================
# UI Thingies seen

### Views

* [ ] Context
* [ ] Text
* [ ] List
* [ ] Button
* [ ] NavigationView
* [ ] Image
* [ ] ForEach - an array of Identifiables for the simple syntax 
* [ ] Group
* [ ] Path
* [ ] Shape
* [ ] RotatedShape
* [ ] H/V/ZStack
* [ ] LazyH/V/ZStack

### view modifier things

* [ ] .transformEnvironment
* [ ] .font
* [ ] .navigationBarTitle
* [ ] .border
* [ ] .frame
* [ ] .onTapGesture
* [ ] .rotationEffect
* [ ] .navigationBarTitle
* [ ] .resizeable
* [ ] .aspectRatio
* [ ] .padding
* [ ] .environment
* [ ] .fixedSize
* [ ] .lineLimit
* [ ] .minimumScaleFactor
* [ ] .truncationMode
* [ ] .offset
* [ ] .matchedGeometryEffect
* [ ] .clipped
* [ ] .cornerRadius
* [ ] .layoutPriority

asdf

### Types

* [ ] EnvironmentKey - requires `static defaultValue`
      - need this to add custom things to the environment
* [ ] EnvironmentValues - lets us use the key as a keypath
* [ ] PreferenceKey - requires default value and a reduce method

==================================================
# Random things of interest

with simple if/else with Text

```
VStack<TupleView<(Button<some View>, _ConditionalContent<Text, Text>)>>
```
which is 

```
VStack<
    TupleView<
          (Button<some View>, 
           _ConditionalContent<Text, Text>
)>>
```

with if/elif/else

```
VStack<TupleView<(Button<some View>, _ConditionalContent<_ConditionalContent<Text, Text>, Text>)>>
```

which is

```
VStack<
   TupleView<
        (Button<some View>, 
         _ConditionalContent<
             _ConditionalContent<Text, Text>,
          Text>)>>
```

The type is all views that could ever be onscreen during the app's lifecycle.

* Once views constructed and laid out, SUI shows them onscreen and waits
  for any state changes that affect the tree.
    - properties that need to trigger view updates are marked with
    - @State / @ObservedObject / @StateObject (among others)
    - "for now" change sto properties marked with any of these will cause
      the tree to be re-evaluated
    - causes `body` to be called again
      - but the type does not change, no matter the final configuration
        of views on the screen (due to ifs and whatnot). Fixed at compile time
      - the only thing that can change are properties of the views and which
        branch of a conditional
      - "the static encoding of the tree's structure has important performance
        advantages" (coming later)
    - changing state properties is the _only_ way to trigger a view update
      - can't muck with the view hierarchy like in UIKit
      - "we have to model the application state explicitly and describe
        what should be onscreen for each given state"
* only one code path, not two (setting up views then changing them)
  - the `body` property is used for all the things
  - impossible to bypass the view update cycle and muck with the tree directly
    - triggering a re-evaluation of the body is the only way to update the 
      screen
* efficiency of updates - can't really just throw everything out - lose
  state like scroll position
  - so SUI needs to know which nee dto be changed/added/removed
  - implementation details bleed through
  - because the type is hardcoded at compile time with all the views
    (views that come/go can show up as optional), the structure is invariant
  - so trade a little bloat in the view type for more efficient diffing
  - tree diffing algorithms are O(n^3)
    - things like React use a heuristic diff with O(n)
    - https://reactjs.org/docs/reconciliation.html
* dynamic views
  - if statements / switch - fully resolvable at compile-time
  - ForEach - number of views can change, but all need the same type
        ForEach(1...3, id: \.self) { x in
            Text("Item \(x)")
        }.debug()
    - like with Lists
      ForEach<ClosedRange<Int>, Int, Text>  // 1...3
      ForEach<Array<String>, String, Text>  // ["hi"]
      ForEach<collection, type of keypathed element, view type>
    - first parameter is the collection (RandomAccessCollection)
    - second is keypath which property should be used.  \.self is the
      identity keypath
    - because each element is identifiable (by index), SUI can figure out
      at runtime what's been added or removed since the last view update
      - plus uniquely identifying elements helps with animations
  - AnyView
    - use any view erased to the wrapped views type
    - can contain arbitrary view trees with type requirements
    - throws away static type information that would help with efficient
      updates.
    - maybe use a Group instead
* view builders
  - to use view builder syntax, either wrap in a group (takes a View
    as the trailing closure or tag with @ViewBuilder
* efficiency
  - to take advantage of smart tree updates is to place state properties
    as locally as possible.
    - worst possible option is to represent all model state with one state
      property on the root view and pass all data down the tree as
      simple parameters - cases many views to be needlessly reconstructed

* Data bits
  - Value Types
    - plain property - for read-only. Like a corner radius
    - @Binding - read and write a value stored somewhere else
        - like from an @State or an observable object.
        - gives the View a way to get, set, and observe the underlying value
        - value is _not_ owned by the view itself
        - most SUI components that modify a value do it via a binding
          - text in a text view
          - value in a slider
    - @State - read/write value managed by SUI
      - SUI initalizes the state before the view is create
      - value persisted when the view is recreated
      - local to the current view tree.  can't access or initialze from
        higer up the view hierearchy.
        - c.f. https://forums.swift.org/t/state-messing-with-initializer-flow/25276/3
      - good practice to mark them as private
    - "personaly, we use @State a lot during debugging and experimentation.
       When we write a component, almost always replace state with binding."
       "when writing a real aplication, almost always replace @State with
        an observable object that persists to disk unless it's only used
        for local, trivial view state'
    - @GestureState- special varient for gesture recognizers.
       - initialized with a value, and then get updated while the gesture
         is ongoing.  Once finished, is autiomatically reset to its initial
         value. _(that seems weird)_
  - class types
    - can conform to observableObject to have SUI subscribe to changes
    - lets SUI get notified just _before_ the object changes
    - @ObservedObject - for when the reference to the object can change
      - causes subscription via `objectWillChange` publisher
      - whenever the properties of the object change, SUI will rerender
      - using a different object, SUI will subscribe to that instead
    - @StateObject - when the reference cannot change
      - initializes the property only once, before the view is created
      - same reference used when view recreated
      - the reference to the object is constant
      - can pass in the value from the outside, the property will use only
        the first value it sees.
      - ony use for local state objects that are initialized and owned
        by the view and can never change (e.g. can't change based on other
        properties of the view)
    - @EnvironmentObject - object passed through the environment
      - chapter 3
  - Observed Object
    - in almost all real-world applications, we want to use our own 
      model objects.
    - to make them observable from swiftUI, it needs to conform
      to ObservableObject (comes from Combine framework)
    - ObservableObject requires `objectWillChange`, which is a publisher
      that emits before the object changes.
      - @Published in front of properties, the framework will create an
        implementation of objectWillChange that emits whenever so-marked
        properties change
      - if you forget @observedObject, code will mostly work, but SUI won't
        subscribe to the objectWillChange notifications and views won't get
        rerendered
* State vs Binding
  - "we typically start out writing a custom control using @State so
     it's quicker to protoytpe. Once we need to store and observe that
     state outside of the control, we simply change @State to @Binding,
     and doesn't require any other changes to the code
  - can create ae binding to a property of a state value.
    - like Knob(value: $state.volume) or Knob(value: $volumes[0])
* Property Wrappers
  - @State ==
        var counter = State(initialValue: 0)
            Button("Snorlg") { self.counter.wrappedValue += 1 }
             LabelView(number: counter.projectedValue)
  - (docs) State is a property wraper type that can read and write a value 
    managed by SUI. State instance isn't the value itself, but a means of
    reading and writing the value.  
    - It is safe to mutate them on any thread.
  - something like slider, it needs an initial value which it can get from
    the binding, and also needs to write changed value back.
    - the slider doesn't care about where that Double comes from or where
      it's stored.  Just needs a way to read and write a Double
      - that's what Binding<Double> does
- Working through chapter two exercise. So main thread (not surprised)
```
[SwiftUI] Publishing changes from background threads is not allowed;
make sure to publish values from the main thread (via operators like
receive(on:)) on model updates.
```

- fun bizarre error:
```
Cannot convert value of type '[Photo]' to expected argument type 'Range<Int>'
    List {
        ForEach(photos) {
```
Notice that there is no explicit argument.  Add a `spoonwaffle in` and
the error goes away.

* NavigationView - one of the steps in chapter 2's exercise.
   - c.f. https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui (video 40min)
   - push and pop screens with ease

* wow.  Xcode templates are openly hostile to supporting iOS 13. #ilyxc

* Getting a syntax error like
```
Cannot convert value of type 'Binding<Subject>' to expected argument type '[Photo]'
```
Make sure there's not a simple error like "accessing a field that doesn't exist".  There's probably a follow-on error like

```
Value of type 'ObservedObject<PhotoRemote>.Wrapper' (aka 'ObservedObject<Remote<WebPhoto, Photo>>.Wrapper') has no dynamic member 'photos' using key path from root type 'PhotoRemote' (aka 'Remote<WebPhoto, Photo>')
```

"has no dynamic member" is the key bit, just buried way deep in a ton of noise :-(

* Environment
  - mechanism SUI uses to propagate values down the view tree, from a parent
    own to its contained subviews
  - it's apssed down the view tree
  - we can call methods (wrap views?) with random stuff - font, foregrondColor,
    etc.  Font on VStack?  linespacing on Color?  how do magnets work?
```
ModifiedContent<VStack<Text>, _EnvironmentKeyWritingModifier<Optional<Font>>>
```
  - wrap with Modified Content - content and modifier
    - so an optional value being written to the environment
    - since being passed down the view tree,  the Text will be able to read
      the font from the environment
      - so for `.font`, an optional Font is written to the environment
  - `.environment(\.font, Font.headline)` - same effect as .font(.headline)
  - the same call `.font` is actually overloaded
    - on Text, it sets the font
    - on VStack, it sets in the environment
    - "this pattern is used throughout SwiftUI"
    - This can have an impact on API design. Consider these two.  Have to make
       the knobPointerSize a function on View
```
   Knob(value: $value).knobPointerSize(0.2)
and  
   Knob(value: $value).frame(width/height).knobPointerSize(0.2)
```
  - environment modifiers only affect direct subview trees and never
    parent or sibling views.
  - `@Environment(\.colorScheme) var colorScheme` - given a keypath into
    an environment, sets up a binding thingie so if the colorScheme changes
    in the environment, this will change and trigger a re-do. Acts like 
    @State
  - Environment is not (just) a global dictionary of values
    - one view's subtree can be different from another
  - a form of dependency injection
    - but usually used with value types
    - @Environment is only invalidated when a new value is set, so if a 
      property of the thing in the enviroment changes, nothing  hapens
    - so use @EnvironmentObject, give it an ObservableObject
       - cases the view to be invalidated when objectWillChange publisher
         is triggered
       - works without a key b/c the type of the object is automatically
         used as the key.
       - _does this mean we can't have say two UIColors?_ - yes
    - recommend to use value type with a key. It can provide a default value,
      and won't die if forget to inject the object
      - wait, what?
```
Fatal error: No ObservableObject of type DatabaseConnection found. A
View.environmentObject(_:) for DatabaseConnection may be missing as an
ancestor of this view.: file SwiftUI, line 0
```
* Preferences - a way to implicitly pass values from the child views up
  to a superview (!)
  - e.g. NavigationView, describe navigationBarTitle, BarItems, etc through
    modifiers.  Those need to bubble up to the NavigationView
  - _ok I can see the need. Kind of a weird name_
    - like .navigationBarTitle on a Text().  The text isn't interested in
      it, but the/a parent view is
  - like with env, a prefernce has
    - key (type)
    - associated type for the value
    - defeault value
  - also needs a way to combine values (like multiple view subtrees define
    the same preference)
  - this stuff kind of hurts my brain. Like this which adds `.blahNavigationTitle`
    that someone can decorate another view.  It returns a prefernce, which
    is a View. :mind-blown-but-in-a-way-that-hurts:
```
extension View {
    func blahNavigationTitle(_ title: String) -> some View {
        preference(key: BlahNavigationTitleKey.self, value: title)
    }
}
```
  - Kind of the money bit:
```
    VStack {
        Text(title ?? "").font(Font.largeTitle)
        // step 5 of custom preferences
        content.onPreferenceChange(BlahNavigationTitleKey.self) { title in
            self.title = title
        }
    }

VStack<
    TupleView<(Text, 
               ModifiedContent<
                   Text, 
                   _PreferenceActionModifier<BlahNavigationTitleKey>
```
  - this means views are rendered twice.  Once with the nil value, then
    subchildren are rendered, which set a preference, which changes stuff,
    which causes things to be re-rendered again.
    - but with the smart diffing, children that are unaffected shouldn't
      actually get rebuilt
    - wonder if it's possible to set up a loop?
  - the "reduce", part of the `PreferenceKey` protocol.  The sample navView
    just picked an arbitary (first seen) value. But you could collect stuff
    in to a collection (so say tab views)

* Layout
  - task of assigning each view in the view tree a position and size
  - the TL;DR
    - for the root view, SUI proposes a size (available space)
    - view lays itself out in that space and reports its actual size
    - container then aligns the root view to available space
  - but of course the reality is every view and modifier has different  
    behavior
    - two dimensions of proposed size
    - nil value means the view can become the _ideal size_
    - each view gets a rectangle, but the view doesn't always draw
      within those bounds. (useful during animutation).  So like kee
      a view's layout position (other views stay in place relative to it)
      but draw with an offset or rotation
  - specific view behavior
    - Path - the layout ignores the bounding rectange of the path. Returns
      the proposed size
    - Shape - has a `path` function, makes it possible to draw a path
      that's dependent on the proposed size. Custom shapes should mimic
      built-in shapes (basically filling the space as appropriate)
  - when doing a .rotation, it draws at its Loco size, but rotates and 
    could stick out of its boundary
    - likewise, doing an offset, doesn't change the layout, but draws the
       shape in a different position (via `OffsetShape`)
  - images have the size of their image.  The layout method ignores the size
    proposed by the layout system and always returns the size
    - to make it flexible, call .resizable
    - .aspectRatio is also useful, includes fit or fill
  - text (this is gonna be fun. Text is usually so simple %-) )
    - always tries to fit its contents in the proposed size
      - returns the bounding box of the rendered text
      - if no newlines, tries to render as a single line. If not, it looks
        to the available vertical space.  If enough, will wrap. if it still
        won't fit (you must acquit), the text gets truncated.
    - view modifiers
      - .fixedSize, prevents wrapping. Text might draw outside the proposed
        fixed size
      - .lineLimit - max number of lines.  can truncate
      - .minimumScaleFactor - allows to be rendered at a smaller size if
        it doesn't fit
      - .truncationMode - beginning/middle/end
  - frames.  Two flavors
    - fixed-sized frames
      - .frame with width/height, and an alignment (by default w/h is nil and
        alignment is .center)
      - the frame's layout will propose this width to its children.
      - also returns the fixed size as its size
      - if one dimension if fixed, uses the returned value from the children
        as the other dimension
      - So Text("blah").frame(width: 100), text's layout will receive a 
        proposed size 100 points wide no matter what the parent view's width
        is.
      - alignment to position child if the size is different than the frame
    - flexible frames
      - give a minimum, idea, and max width/height
        - min/max clamp
      - don't quite grok the description on page 68 "The ideal dimensions"
    - to propose a nil dimension, use .fixedSize() modifier
      - "it's a counter proposal"
  - padding
    - "one of the simplest around"
    - full version takes EdgeInsets (padding per edge)
    - without args, use default
    - when layinig out, the padding modifier subsstracts the padding from
      the proposed size and then proposes it to the child.
      - then adds the padding to the returned size
    - can have negative padding
  - overlay / background
    - content.overlay(other)
    - proposed size is passed to content. Then reported size is psased to
      other as proposed size. Overlay reports back its own size (ignoring
      other)
    - background is the same, and other is drawn behind content
    - content.overlay(other) != other.overlay(content)
      - first case, `content` size returned.  Latter case overlay's size is used
  - drawing modifiers
    - don't affect layout, just drawing.  They identity-matrix the sizes
      flowing through them
    - .offset causes to be drawn at a different position.  Useful during 
      animations and interactions
      "can use offset to move a dragged item to the drag position while
       still maintaing its space in the list"
  - matchedGeometryEffect
    - give one or more views the same geometry properties as a single source
      - target views can choose to be the same size
      - or "align at the same position as the source"
      - or get the same _frame_ - size and position matches the source
      - "mostly useful for animations"
    - also has _properties_ and _anchor_ parameters
      - properties - can specify if the full frame or jsut the position or size
      - with .position, anchor is used in to align the views
    - make sure the destination view are able to be as large as the source
      - if they need to shrink, it can "be aligned in unexpected ways"
    - doesn't affect layout, just how it's rendered
    - also useful in animations
  - clipping and masking
    - don't affect layout, but influence what's drawn
    - .clipped - view is clipped to the bounding rectangle
    - .clipShape - takes a shape
    - "rounded corners with .cornerRadius are implemented by clipShape
       with a roundedRect"
* SnackViews
  - "essential mechanism for building up complex layouts from individual views"
    - H/V/Z stack
  - iOS14+ SUI has lazy versions - LazyHStack/LazyVStack
  - layout (at least HStack)
    - first pass - figure out the flexibility of each child
      - determines the min and max width a view can become
      - the largest number is the most flexible
    - second pass - divide up the space starting with the least flexible
      child (that would be me) and ending up with the most flexible
      child (that would be my sister)
      - subtracts all the necessary spacing between the views from the
        proposed width.
      - loop over children
      - take the remaining width and divide amongst
      - proposes to the least flexible remaining child.
      - repeat
    - width can nver go negative.  If run out of space, the chidlren will
      get a proposed width of 0
  - affecting layout
    - if there's priorities, the child views not sorted by flexibility,
      instead grouped by the priority, the nsorted
  - off-axis alignment (like horizontal jiggering in a VStack)
    - using _alignment guides_
    - each stack view has a single alignment guide (two for ZStack - H and V)
    - default is center, also exists baseline
    - during layout, ask each child view its layout value (e.g. center)
      - all the centers placed on a single line
    - can create custom alignments - really easy
    - also can override the alginment guide for a specific child view.
      - Cool, can compute the value on the fly too
      - only works with custom dimension?
    - can also use .offset
      - offset only changes drawing, not offset
      - alignment guide _does_ change the layout
* Grid Views
  - 2D grid.  HGrid grows horizontally, VGrid vertically
  - create content lazily
  - three kinds of column (or row - only going to mention one axis from now on)
    - fixed - fixed width
    - flexible - can be any width between min/max values
    - adaptive - flexible with multiple items
      - SUI will fit as many items into an adaptive column
  - looks like these are iOS 14 only. But all devices that support 13 also support 14
* getting reading fatigue.  Want to actually start using stuff.



==================================================
# UIKit and SwiftUI, sitting in a Tree (hierarchy)

* UIHostingController. 
* pushing SwiftUI into UINavController - Well, that was easy
```
        let splungeView = SplungeView()
        let vc = UIHostingController(rootView: splungeView)
        navigationController?.pushViewController(vc, animated: true)
```
* then pushing UIKit from SwiftUI inside of a navcontroller
  - UIViewControllerRepresentable - has a `makeUIViewController`. 
  - Then give that to `NavigationLink`
```
    var body: some View {
        Text("Greeble").background(Color.blue)
        NavigationLink(destination: ViewControllerView()) {
            Text("Flongwaffle")
        }.navigationBarTitle("Navigation")
    }
```

==================================================
# Hints

* put borders around views to visualize the frames
* want to put in a print statement?  Need to explicitly return the
  view.  Otherwise you get weird errors.
```
   var body: some View {
      print("snorglewaffle")
      return VStack { ... }
   }
```
* don't just Enviroment all the things.
  - first expose customization options as simple view parameters
  - then if notice a more decoupled API would be useful, it's easy
    to change to use the environment.

==================================================
# Neat!

```
extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
```
and then do `.debug()` off of say a VStack


each statement in a view builder gets translated into a different type:
  - single statement (e.g. Text) evals to the type of that statement
  - an if statement without an else becomes an optional
  - if/else becomes _ConditionalContent<Type1, Type2>
    - in a view builder, the two branches of an if/else can have different
      types. No bueno with regular if statements
  - multiple statements translate into TupleView, one element for each
    statement.
  - (at the moment) can't write loops or guards

Views are short-lived _values_ conforming to the View _protocol_, vs
UIKit with long-lived classes UIView/Controller

They describe what should be on-screen, but don't have a 1:1 relationship
with what you see onscreen

uiKit splits view construction and view updates into different codepaths.
SUI unifies them. Whenever the state changes, the whole tree gets 
reconstructed (witnessed by the sonic breakpoint), and SUI makes
sure the screen reflects the description

REMEMBER that this isn't UIKit.  VStack{..}.frame(width: 200, height:200)
isn't setting the frame, it's making a wrapper view around the VStack that
really wants to be 200x200, thereby constraining the space the VStack has
available to it.


:mind-blown:

with this - both are called on each update it knows (IT KNOWS) that the
LabelView depends on the @State counter and so gets refreshed, as does
the CounterView.  Each tap, two view makings

```
LabelView: View
  let number: Int
  body {
    if number > 0 { Text("hello \(number)") }

ContentView: View
   @State var counter
   body {
     VStack {
         Button...
         LabelView(number: counter)
```

with this, on updates, only the labelView is called each update

```
struct LabelView: View
  @State var counter
  body {
     VStack {
        Button...
        if counter > 0 { Text("tapped \(counter)") }

ContentView: View
  body {
     LabelView()
```

so SUI only runs the body that _uses a @State (and friends like
@ObservedObject).

Now, if the projected value is passed and only used in a subtree, won't
cause the supertree to be recomputed.  This still only causes the LabelView
to be rehydrated on each tap

```
LabelView:
  @Binding var number: Int
  Body {
    Text("yay \(number)")

ContentView:
  @State var counter
  body {
    Button { counter += 1 }
    LabelView(number: $counter)
```

So by keeping track of the use of the projeced value, SUI's diffotron knows
that even though counter is refrenced (via $) and is a property of the
view, the only thing that is substantivelly affected by it is the LabelView.

* on branch tis_ch2_ex_s3 - the views updating when the array finishes loading.
  That's freaking amazing magic.

* COOL.  See the contents of the environment.  
    `.transformEnvironment(keypath) { dump($0) }`
    Can use keypaths like \.font, but also things like \.self to see
    :allTheThings:

```
    Text("Hello, world!")
      .transformEnvironment(\.font) { dump($0) }
yields
▿ Optional(SwiftUI.Font(provider: SwiftUI
                                  .(unknown context at $1b472f518)
                                  .FontBox<SwiftUI.Font
                                  .(unknown context at $1b474dfa0)
                                  .TextStyleProvider>))
  ▿ some: SwiftUI.Font
    ▿ provider: SwiftUI
                .(unknown context at $1b472f518)
                 .FontBox<SwiftUI.Font
                 .(unknown context at $1b474dfa0)
                 .TextStyleProvider> #0
      - super: SwiftUI.AnyFontBox
      ▿ base: SwiftUI.Font.(unknown context at $1b474dfa0).TextStyleProvider
        - style: SwiftUI.Font.TextStyle.headline
        - design: SwiftUI.Font.Design.default
        - weight: nil
```
