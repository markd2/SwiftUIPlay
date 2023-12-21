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

