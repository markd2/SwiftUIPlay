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

