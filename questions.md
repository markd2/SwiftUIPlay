# accumulated questions

* [ ] What is `@State`?
* [ ] what is `some`?
    - "whatever the exact type of the body might be, it definitely conforms
       to the View protocol"
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

c.f. https://developer.apple.com/documentation/swiftui/dynamicproperty#relationships

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
