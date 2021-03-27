# Design notes

Sketchings for from-scratch sample apps.


----------
### Filterator

Had a question about design / MVVM / SwiftUI / Combine, and I know I am totally 
not up to speed on that stuff.  I got some great design advice on doing a "big list
plus multiple independent filters" that kind of turned my world upside down.

So this thing is (hopefully) going to be three implementations of the same thing, using
traditional comfortable UIKit, UIKit + Combine, and Purely SwiftUI.

#### Requirements

Have a big pile of random People objects, with things like shoe size (continuous
values), blood type (discrete), and Name (text searchable).

Then have three filtering panels, each one allows filtering by a particular type.

I have a feature I'm building that's similar. The kinds of filtering and slicing and
dicing is still open-ended ("oh wouldn't it be cool if we did...")


#### Design

* Traditional UIKit
    - Panels are view controllers
    - They provide a filtering callback closure, plus some kind of trigger to let the
      list know to reload itself
* UIKit with Combine
    - Panels are view controllers
    - Via combine triggers a central "DataGod" (see slack snapshots) that causes
      the list to filter
* SwiftUI
    - Panels are views
    - Bindings

Slack Snapshot [one](assets/thing1.png) [two](assets/thing2.png) [three](assets/thing3.png)

Thanks to https://www.everydayknow.com/500-fantasy-surnames/ and 
https://www.everydayknow.com/500-fantasy-surnames/ for the person name generator
source data.

#### Learnings

##### UIKit

* Xcode storyboard editor keeps getting worse and worse with each
  version.  (like, to go freeform in VC view size, you have to focus
  another file and come back to get the safe area guide to go away;
  sometimes the left gets a max width way too small to show the
  non-horizontally-scrollable view debugger outline.  I miss the days
  of dev tools with more than a couple of hours of uptime because either Xcode crashes
  or vomits all over itself and needs to be restarted to clear the yuck out), plus the
  usual autolayout horror. Tried to have a two-slider shoe size
  filter, but xcode + autolayout + stack view just totally refused to
  cooperate, and it's not worth it.  ARHGHGHGHG
* I miss the days when there was pride of craftspersonship.  Trying to rename one of
  the VCs, Xcode doesn't rename the corresponding xib file (even though they were created
  at the same time...), plus the UI cuts off half of the things it's supposed to be
  showing, and the resulting git staging is a mess.  If you renamed and then committed,
  only half would actually happen.

##### UIKit + Combine

* notes from the above slack convos
  - `DataGod`, has a @Published array of results
  - `Filters`, things like bloodType and shoeSize
  - in the panels, do self.dataGod.filters.bloodType = .A
  - using a value type for the filters so the didSet obserer triggers everytime 
    a bit is flipped
  - all the panels care about is having a pipe to read/write their leaf of the filters tree
  - in SwiftUIspeek, describing a Binding<BloodType> branched off the filters
    - `BloodTypeEditor(binding $dataGod.filters.bloodType)
  - in UIKitland, it's less fun - need a block like I've got, or a reference to DataGod
    or some other DataGodlike protocol
    - "this'll port over to SwiftUI in a heartbeat"
* so thinking in CombineTerms,
  - DataGod has the published set of results
    - updating that set will trigger updates (say to the table view)
    - something will need to trigger that update to ultimately update the table



----------------------------------------

### Choosinator

First stand-o-lone app.  Something I needed to figure out how to timeslice a day.


#### Requirements


- text field.  Enter text.  Add string to list
- push a button, it chooses one of those strings at random
  - sticks it in a label.
- list of streams is ephemeral, no need to save it anywhere

#### Design

* View that has all the things.
* since ephemeral, it can just hold stuff in the view (`@State`)
* data
  - array of strings
  - randomly selected item

#### Learnings

This was pretty easy.  **except** the really unusual and off-the-main desire
to ... focus a text field.  Right now you have to re-tap the text field each
time you add an item because apparently SwiftUI is unable to do that. Looks
like you have to wrap a UITextField, or pull in Introspect and other auxiliary
code.  c.f. https://stackoverflow.com/questions/56507839/swiftui-how-to-make-textfield-become-first-responder

So skipping that for now.

