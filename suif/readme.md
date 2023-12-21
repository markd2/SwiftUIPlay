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

