# Visual Guide Notes

From https://www.bigmountainstudio.com. Checking out the free SwiftUI Views book.

Build a UI with **Views** then change those with **modifiers**.

Collections
  - VStack
  - ZStack
  - HStack
  - and abednego
  - Grid

Parent/Child relationships

Views with no children of their own are **leaf views**

Parents can have modifiers that apply to it and its children views, and can also
have specific modifiers that override the default.

`some` keyword - the view returned is an _Opaque Type_.  heh "it's hard or impossible
to undestand what type of view is being returned, but you know it **is** a view.
Like a box of books.

In addition, with `some`, all possible return types **Must be of the same type**.  Unlike
say with a regular protocol, you could return anything so long as it CONFORMS to the protocol.

Adding `.frame(maxWidth: .infinity)` is "keep going until you hit the parent's
frame, and then stop"

Add .padding() before any .background() modifiers.


