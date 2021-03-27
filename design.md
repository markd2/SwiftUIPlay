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

