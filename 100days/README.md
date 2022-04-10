# 100 Days of Swift

Some of the cool kids from Andy Stefani's tuesday morning Swiftogether are doing
the twostraws 100 days of Swift, and the code they showed of their own app was
clean and clever.

https://www.hackingwithswift.com/100/swiftui

First 15 days were review, so skipping.

### Day 16 - Starts WeSplit(tm)

* Form.  
* Pervasive 10-view limit. Use Group to get around that. 
* Section to have visible changes. Looks like a classic segmented tableview
* Add a NavigationView to hide scrolling a form from going under the status bar.
```
   .navigationTitle("Snorgle")
   .navigationBarTitleDisplayMode(.inline)
```
* actually go on the innerview, not on the NavigationView itself

"Our views are a function of their state"

* Button
* @State - allows the value of a struct var to be stored separately in a place that can be
  modified
* SwiftUI destroys and recreates structs frequently, so keeping them small and simple is
  important
* @State is for simple properties that are stored in one view.  Recommended to make private
* get the projected value (e.g. $name) for giving to a textfield, to make a two-way binding
```
   TextField("Greeble bork flonk", text: $name)
```
* ForEach to loop over stuff and add more than 10 views to something
* Picker + ForEach.  use `\.self` to say "the contents are naturally unique"
* TextField taking a non-text value (say a Double $binding) in the *value* (not text)
* Picker outside of a form gives the wheelie
* Declaritive UI design - say what we want vs how it should be done
* Navigation title goes on interior view, not the NavigationView, b/c we could have
  many views, each with its own title.
* Get segmented controll by using segmented pickerStyle on a Picker
    .pickerStyle(.segmented)
* can add a header: on to a section for a label
* @FocusState - like @State, but designed to handle input focus

* VStack.  VStack(spacing: 20).  Same 10 view limit
* alignment: .leading, .ignoreSafeArea()
* Color.red in ZStack vs .background(.red).  Colors take up all the space aailable
* .frame() modifier, width:height, and minWidth:maxWidth:maxHeight
* Color.primary - default text color. Color.secondary with a bit of transparency
* Color(red:green:blue:)
* .ignoresSafeArea()
* materials - .background(.ultraThinMaterial)
```
LinearGradient(gradient: Gradient(colors: [.white, .black]),
               startPoint: .top, endPoint: .bottom)
```
* Stops as well (.init vs repeating Gradient.Stop)
```
            LinearGradient(gradient: Gradient(stops:
                                                [.init(color: .white, location: 0.45),
                                                 .init(color: .black, location: 0.55)
                                                ]), startPoint: .top, endPoint: .bottom)
```
* ooh this is purty
```
            RadialGradient(gradient: Gradient(colors: [.blue, .black]),
                           center: .center, startRadius: 20, endRadius: 200)
```
* rainbowz
```
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
                            center: .center)
```
* Giving a function to a button: Button("Snorkleblah", action: bunkflob)
* Button roles, like .destructive
* .bordered / .borderedProminent / .tint(.mint)
* Can provide a label: closure for the custom label.  Useful for images
* Images.  decorative: won't be read in screen readers, otherwise will read image name
* text + image: `Label("Snork", systemImage: "tortoise")` in the button label:
* renderingMode(.original) if images are getting blasted with blue
* When showing an alert, don't think of it as "show the alert", but instead
  create our alert and set the conditions under which it should be shown. (kind of
  active vs passive voice?)
* .alertModifier - doesn't matter where it's used, just saying that an alert exists and
  is shown when the property is true
```
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Snork Greeble", isPresented: $showingAlert) {
            Button("Flphphpph", role: .destructive) {}
            Button("Flphphpph", role: .cancel) {}
        }
    }
```
* And aux mesasge in a message: closure
* .font(.subheadline.weight(.heavy)) | .font(.largeTitle.weight(.semibold))
* .bold == .weight(.bold)

* "Our views become simple inert things that convert data into UI, rather than
   intelligent things that can grow out of control"
* "There is **nothing* behind our views" - what you see is all we have, so if your
  view isn't big enough to e.g. fill in the background, thn all you can do is
  make that view take up more space.
* .frame(maxWidth: .infinity, maxHeight: .infinity)
* maxwidth/height says that the view _can_ consume the space, not that it must
* applying a modifier creates a new view - doesn't modify the existing view
  (it is a lightweight struct after all)
* can also think of it like "the views are rendered after every single modifier.

* "opaque return types" - the `some View` thing. @ViewBuilder auto wraps into a TupleView
* can use ternary operator to e.g. decide values inside of an expression
* There's also `if` - but that makes more work (since the if is done at Swuift-UI processing
  time, plus say for foreground color, "it will destroy one or the other rather than just
  recolor what it has", so prefer the ternary
* environment modifier - having a modifier (e.g. `.font(.title)`) on the VStack rather
  than each individual Text inside of it.  If a child view inside the VStack uses
  the same modifier, it takes precedence
  - vs regular modifiers, like blur(). Not a dfinitive list of either, so need to look
    at the docs and hope it's mentioned
* can factor out interior views into let properties.  Beware of using other properties in
  that view definition
* can also have computed propertes - `var blah: some View { yay }`.  These aren't
  @ViewBuilder, so for returning multiple views, put in a stack, group, or add
  @ViewBuilder
* of course, don't let things get too complex
* Make custom modifiers with making a new ViewModifier - `body(content:)` takes a view,
  and returns an appropriately decorated view
* Use via .modifier(GreebleModifier())
* And add the syntax sugar:
```
extension View {
    func greebleStyle() -> some View {
        modifier(Greeble())
    }
}
```
* They don't just apply existing modifiers, but can return a whole new view structure
* custom view modifier vs a View extension?  The custom modifier can have their own properties


----------
BOOP - 
JSON Editor

RevenueCat - for subscriptions
StoreKit 2 - nicer
----------

stopped at Day 32:
https://www.hackingwithswift.com/books/ios-swiftui/animation-introduction

