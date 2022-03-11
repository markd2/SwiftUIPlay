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