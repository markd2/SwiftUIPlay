# Design notes

Sketchings for from-scratch sample apps.

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

This was pretty easy.  **except** the really unusual and off the main desire
to ... focus a text field.  Right now you have to re-tap the text field each
time you add an item because apparently SwiftUI is unable to do that. Looks
like you have to wrap a UITextField, or pull in Introspect and other auxiliary
code.  c.f. https://stackoverflow.com/questions/56507839/swiftui-how-to-make-textfield-become-first-responder

So skipping that for now.

