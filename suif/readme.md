# SWUIF

# 1

What is a view / how customized / sized and positioned

Modifiers have order.

E.g. `text . padding . border` has a wider spacing than `text . border . padding`

each modifier returns a new view

Text . padding  gives us a `ModifiedContent` with children Text and PaddingLayout

Text . padding . background has two modified contents (the prior mod content, with backgroundModifier)

Sizing:
  - parent proposes size to childrens
  - children return their actual size
  - children are centered in the parent

So like a Text, the proposed size is the whole screen.  The actual size is the snugly around the text

So something like
Ellipse().fill(x)  fills the whole screen, save some safe area below the notchIsland and the bottom swoopybar.

Child size can be _____ the proposed size
  - smaller
  - same
  - bigger than

(I think that covers all the cases)

Applying modifiers changes the type of `body`, hence the need for `some`

mastering the ordering of modifiers is SUIs early challenges.

by default views don't clip their content. (e.g. the cornerRadius causing a shadow
before it to disappear, but if put after, it can draw outside of its proposed parental
bounds)

Good to test views in different configurations and environments

# 2: Snaks

the usual snackage

there exist alignment: and spacing: arguments
  - like vstack alignment .leading flush-lefts the views
  - and hstack alignment .top aligns the tops of the child views
  - and zstack .topleading does the same (but smashes things on top of each other)

sizing algorithm:
  - subtract inter-view spacing
  - divide up space equally
  - distribute from least to most flexible view

Frames can have alignments (e.g. .topLeading) to move things around inside

Flexible sizes:
  - minWidth / idealWidth / maxWidth
  - minHeight / idealHeight / maxHeight
  - alignment
(the widths are optional floats. Alignment things like .center)

with zstacks, earlier views are behind later views

# State and bandage

Displaying dynamic data

@State - value managed by swiftui, UI updates on state change

use projected value ($count) 

Star Citizen joystick sensitivity curves  - flight movement, make 2.0 across the boad

A binding is a two-way conduit between the two views

Source of Truth - @State is internal data managed by the view and IS a source of trooth

@Binding is external data managed by another view, is NOT a source of trooth

https://www.elgato.com/us/en/s/epoccam - for wireless phone webcam

Button can have a `label` closure in the initializer to make a view for the button
(vs just text)

toss in a `withAnimation` to, well, animate
  (Returns the result of recomputing the view’s body with the provided animation.)
"This function sets the given _Animation_ as the _animation_ property of the thread’s current _Transaction_."

e.g.

```
Button {
    withAnimation {
        blah.toggle()
    }
} label: {
    // stuffs
}
```


# Tabs and corrections

ForEach(thingie, id: \.keypaf) { ... }

Or use Identifiable

.tabItem for specfiying a Label,w hich is a title + icon

.tabViewStyle(.page) for paginated.  Will use the tab icons instead of dots - that's kind of cool

and something about styles: a way to encapsulate the appearance of the view separate from its
internal logic.  Like tab view has .automatic and .page

# Presementations

sheet - presented interface that can be dismissed when the user has completed
some action

(plus environment)

temporarily work on different tasks, drag to dismiss

use .sheet (with an isPresented: binding of a bool) for what to show in a sheet.

hard way to dismiss programatically is to pass the binding in to the sheet view.

Other option is to dig into the Environment: 
```
    @Environment(\.dismiss) var dismiss: DismissAction
```

        case '
': self = .card

Environment is a collection of value types that propagates _down_ the view hierarchy.
Values can be overridden.

Lots o options, like

Font / dynamic type size / line limit
allows uer interaction
editng mode
dismiss action
accessibility settings
layout direction / locale / calendar
color scheme

A view can change its environment, then subviews will use that changed environment.

Override a value with something like
```
.environment(\.font, .system(size: 50))
```

OOOH, things like `.font(.title)` are conveniences for `.environment(\.font, .title)`

Other presentation modes, like full screen cover, poopover, action sheet, alert, confirmation dialog


