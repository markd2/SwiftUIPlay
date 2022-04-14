# SwiftUI is Being Used, the role of Passive Voice in SwiftUI

A rambling pile of nonsense.

a refresher of passive voice, by zombies

Andy Stefani's group.

So, working on 100 days of swift

Came across this

  When showing an alert, don't think of it as "show the alert", but
  instead create our alert and set the conditions under which it
  should be shown.

it should be shown

conditions under which IT SHOULD BE SHOWN, by zombies

huh passive voice.

I still have a HARD TIME with SwiftUI.

UIKit is a classic UI toolkit style, even though developed in the 80s, came into
style in the mid 90s.  Very Active.  "You! Label!  I'm setting the label!"
"Ooh a button tapped!"  "I'm going to reach into this view hierarchy and
CHANGE STUFF!"  Close to 30 years of programming this style.  THIRTY YEARS.

SwiftUI is different -  user interface changes because some data changed.

View hierarchy - various dependencies.  If a dependency changes, just the view
  changes.
Sources of Truth.
Places where data lives
  - @State
  - @StateObject / @ObservableObject
  - @Binding
  - @Environment

It's not been the first reversal of concepts I've seen. 

Like, this audio pipeline of a synthesizer going into a set of effects, going into
a mixer, and going to speakers - sounds is coming from the synth into the effect, where
things change which go into the rest of it and out the speakers.

Yay real world.

But in software, it's backwards.  (AU diagram, pull model.  "ooh!  it's a new clock
tick.  "Hey everything, GIVE ME your data".  
  - hey Mixer, give me your next couple of audio bytes
  - Mixer goes 'hey effects, give me your audio bytes'
  - each effect goes 'hey synth, give me your audio bytes'
  - The synth goes "ooh!  ok, I'm in this part of the wave cycle, so write the next 
    couple of milliseconds of audio to this buffer"
  - then cascades to the end
  - PULL MODEL.  And it's weird. But have to understand it to set up audiographs
  - (MJ picture)

And that got me thinking about us, our roles as programmers, and how it's evolved

* old-old days.  No OS. You owned the machine
   - two waves - the original machines, plus the early PC / 8-bit era
* Mac kind of turned that on its head
   - "everything you know is wrong"
   - "Sit in a loop, we'll tell you when the user does something interesting for you"
     - so it can do things like desk accessories

- "I am going to be in complete control" that was common for 8-bit and PC programming
   - "You're running the entire restaurant"
- vs mac
   - "You're back in the kitchen getting orders"
- vs MacApp / NeXTStep
   - you get notes written on slips of paper slipped under the door in the pantry 
- and SwiftUI?
   - the analogy kind of breaks down.  Maybe you're a cockroach under the refrigerator
     units

But, we as programmers are getting shoved higher and higher up the abstraction stack.
Which is kind of nice - the things we're learning are individually easier, but kind
of more of them.

We still have all the stuff.  We still have

microprocessor
OS Kernel
Core libraries
UIKit
SwiftUI on top of that

And each time you get hoisted, it's a new set of skills to learn, and a set of 
old skills to unlearn.

Anyway, so I'm learning SwiftUI.  Good Villain.
