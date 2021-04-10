# Practical Uses for Combine

David House with CocoaHeads/Atlanta - 8-April-2021

M: How much of cache do you have time availability for
   brief overview to get ramped up and into the conversation

H: we can go as deep and shallow on the demo and coding. Other thing
   ease our things as I get to the different topics.  I'll try
   to make sure we're covering the basics.  Won't be going into
   advanced, but "how do you use Combine". If it feels like
   getting too deep, will backtrack 

M: Do your think and we'll ask questions.  Thank you!

H: Essentially when Mikey was asking some potential  topics,
   gave 3 or 4 things, Practical Combine, PLEASE do that one.
   Right now working on a mac app for a client and using swiftui
   and combine, actually learned a lot of things about how I can
   use it practically, went through last year to wrap around what
   it is, why do I care, but it took me starting to build an
   app before those things are sinking in now, and thinking more
   in the Combine way of thinking and building my app to map
   those things. Would love to do is show the app and show the
   practical examples, and can't do that. But have come up with
   an example little App just for this demo covers a lot of the
   cases what  .. now, and spur your thoughts.

   A few other caveats, I'm still learning best practices and
   how I think it should be used. If you ask in a month I might
   have a completely different opinion.  The important thing is
   thinking through the journey and the problem space, and 
   [un] fortunately, will be a talk on SwiftUI app architecture,
   that's the context we're going to be playing in, and help
   to understand those points we'll add combine to, but not
   anything too crazy

First, show the app.  Pull it out of the oven first, then walk
back to the ingredients, and build it mostly together and
see what going to look like.

Hand one idea, LOTRBall, theres a game "Battle for Middle Earth",
this is sportsball for middle earth - this is for you.  Can click to
start game.  same rules as baseball, but with the two sides of
LoTR.

Have a batter, Sauruman, with information (occupation / Race),
swing, simuate something. Sauroman is Out.  Now batting is Sauron.
A little simulation.  (has a list of action).  What we're going
to build.

Going to be some contrived setup, to do a demo and explanatino
need to set things up for some topics. WOuldn't be how I'd build
for real, but it's close.

(ooh, it's recording)

All SwiftUI

App Arechtirue.

## Services
- services should be smart
- should provide interface using publishers
- can wrap existin/legacy closure APIs into publisher

Servies your rest of your code can do to do work,
it may go outside of the app, but in genereal a bit of
code that will give it some work, it's going to do that work,
and give me back some kind of result.

Services should be smart - fit well into combine,
it'ss trying to turn things into streams of data, not kust
one piece of data, or data+code when data is
available, but a stream of event that all
contain a piece of data.  Easier to see
when SwiftUI is built, reactive nature, when
this piece of data changes, the screen changes.
Services can be built in the same ways, think
of the way that we think of them as a stream
of data, and makes things really nice.

Sometimes you have legacy APIs that use closures
and idfferent techniques, you can wrap them
in combine publishers.

Lets' look at some publishers, and see the basics, then
get into this other fun stuff.

The Ingredients we're going to use.

Player Info Service - similar to if you were going to
call an API. b/c there is a LoTR API endpoint you
can call, and REST API you can pass in a character and
will give you back some JSON with cool data.
That's the kind of service that player info is.

I have a player name, and get back their information - their
official name / occupation / race. 

Using an idenfier getting a model back of data.
Your typical service.

If you were writing this w/o combine, think a
good way to do it - give me closure or something
when async work is done, here's the closure
I want you to run.  Can use other libraries
(like Deferred) for dealing with futures
and promises.  Lots of ways we've come up
with over the years - have an idea of something
thingie in the cloud, and happens asynchronously.

With combine, this is going not look
terribly different, what we're doing is
return a Publisher

func playerInfoSerice(playerName: Sttring) -> AnyPubhlsiher(Player, PalyerINfoError>

"The thing that is going to generate event sinto this stream
of events"

For this kind of service, we are giving some
methods that will give me a publisher
that will _eventually_ emith a player or an
error.

Super quick note about services - if you
want to see a full networking stack built
on Combine, somethign I can show you, not
the purpose of this per-se.

One thing I liek to do for services, is
create a protocol, and make a real implementatino
that communicates with the service, and
a fixture that deals with local data and
returns data locally and don't have to
have a network connection to test.

Making these fixture versions are good
for unit testing UI automatin, giving
a build to your QA depart can test w/o
dealing with service outages.  Why ther's
a protocol, that's why.

_dict_

Just and Fail

Just - emit data
  - also want to tell the publisher into a different type of
    publisher, have an error

return Just(player)
  .setFailureType(to: PlayerInfoError.self)
  .eraseToAnyPublisher()

What it does is take in one type of publisher,
and returns another type.

Just Player - giving it a publisher w/o any
kind of error information. 
  .setFailureType - is a different type
   of publisher

eraseToAnyPublisher - erase the complexity
of the gunk to the swift type system.
It's going to look like the ->Type at the
end. It's turning the complex under the
hood types of Just and.setFailureType
into anyPublisher.

Fail - emit the error
it already knows the type, has the error,
and a simple erase to any publisher.

This is a simple way to return a publisher to
caller and fill it with data.

----------

like a swing result services - a legacy
service with a completino.  Like how to
turn this into somethign combine can work
with easily. All this is doing is when
one of our batters, will gives a random
element from swing results enum.

Next service, the Roster Service.  This is
more of an example of a service that is more
persistent - has its own state, and that state
can change over time and you poke it with
some kind of method, and the state changes,
and let me know the state has changed.

Has three combine-based properties we
can subscribe to, when  things change, I
can get something in that event stream and
react to that.

One of the apps workign on, has a USB 
device that it interfaces with, have a similar
type of service, when connected, there a
publisher that the device is connected and has
device info. When not connected know that as
well, and if there's data, it will send
that thorugh the publisher as well.

These properties (curreentBtter.. ntoifcations)
using "subjects" -these are aweseom and
use them a lot, they make sense, where
makign a stream of anypublishers doesn't.

The current value subject is one I find
useful, it is as publisher that will publisher
a string value, never publish an error

CurrentValueSubject<Strnig, Never>(BadTeamRaoster.saurum.name)

it always has a value.  I can just ask it for
its current value, it keep that, and also
publishes when taht value changes.

(Current batter /current team)

PasshtroughSubject is simlar - it doesn't
retain the value.

(notifications)

This service has the state around current
batter of team, then a stream of
notifcications for "now batting" and
send those out the stream.

Then set properties, and then the priperties
changes you can subscribe to.

Finally, the GameLogicService, handles the 
whenever there is a game state, and when
one of the batter swings and gets a results,
this transitions the state to something nw.
If nobody is on base and someone hits a double,
then someone on to (sports  talk)

It also has that notifications stream.. We'll
gloss over the teamPublisher thing.


## Views
if you know swiftUI shouldn't be crazy.

- make views as dumb as possible, their job is to display a viewmodel
- view model for every view (exception for component views that display only primiitves)
- any user interaction shoud be comuicated to view model

in views, make them as dumb as possible.
Their job is to display the data. Little
logic other than how to display data from
the view model. All the views have a view
model other than simple views (string,
bool), otherwise they should ahve a vieww
model.  If they have an interaciton,
shold be communicated to the view model.

Some of the views.

all views have view model passed inthe
environment, and then use that to
display in the screen. Like if viewmodel
has an error, show error, otherwise show that.

The playing field is that lovely bit of
grpahics programming,  (rectangles and stacks)

ActionBar view - view at the bottom,
a button, whenever click the button,
we'lre calling to the view model to do the work.

e.g. viewModel.swing()


View Models

-ObservableObjects
  provide the data
- private(self) all publisher
publishes connected with
-any data updates happen via passed in publsihers.
  data modelchagnes via publisehr
our source of  truth.
- handle ui actions from view
- may need to pass publsihers down to child view modes
or between view models

i ngeneral think about source of truth,and can
be a bit of work to propagate up or down.
if you want to put at the top all the time?
when running into SUI and getting thing over
thing, answer is to move it up in the hierarchy.

Start implementing what I just talekd about.

Say the NowBattingViewModel, getting into
the combine and reactive minse.

the VM is are all @published, so if
use model.playername, whenever the value
changes in the property, sui knows that
it needs ti pudabe the view

That is your stream of data. When one
thing changes, that chagnes what the view
is. Simplistcally not all that easy, but
conceptually think from back end to the
front end, if you can just get that data
and put it into various streams until it
gets here, then boom will show up on the view.

!!!  My suggestion is start with your views,
then build view models, and work backwards
from there. If you follow the few principles,
find things kind of fall in to place where
you expect them to go


I got all my published properites a private(et),.
ou can't set them. Don't want the sources
of truth, don't want something poking in
source of truth.

The way you do that is through piublishers.
Creating a nice connection point that other
parts of the app can send a stream of data
through, and change this view model.

Thinking about htis one in particular,
two pieces of data - one is that
player information, from the payer service,
and the messages that come from the who'se
batting, a text message

make an intialzier
- get passed in those two publishers.
To use this VM for anything interesting,
need a way for its data to change.
To change this view model, I need two
publsihers, one that will give me
a player, and a playerInfoError,
and one that will send me messages.

Again thinking in our combine term of
streams, when a player gets put into this
player publisher stream, its goign to end up 
in my view model, and whatever inside of
this will determine how it ends up in our view.

NEed a way to subsribe to changes and
apply them to our VM>  So start with our
player publisher, 

Take the publisher, and describe how
to deal with the data coming in.

make sure on teh main queue.
.receiveOn(on: DispatchQueue.main)

then .sink receiveConpletion
   - set the errorFindingPalyer bool
receiveValue
  - set the view model properties from
    the incoming player
sink is a way to subscribe and handle
the data that came in

And then store this subscriber that it hangs around.

it's pretty simple, just receiving a value,
and updating our properties. 

Also want to deal with the messages,
and that is very similar.  Remember
messages is a publisher with no error
type, always get a string.
So doing a simple .sink, pin to the array,
and if itgets too big, reomvoe the first
thing.

I want the view model to do the work (like
the six-window). It's 100% testable,
easy to write unit tests around the
publishers, and test all that logic
inside of it. This is how you translate
data in one format in one way or another.

"why sink"
Mikey: same deep historical usage of
sink in house, heat sink, used to
describe the last place the flow of
whatever is flowing exists before it
exitss your sphere of influence.  The
last place you see water before it's gone.
The terminus.  (and the whole metaphore
is streams)

Mikey: I have a question about updating
these source of truth properties. imagine
someone might be observing that player name.
b/c @publishe.d update player name, is
that then going to trigger, for other
observers of that property updates elsewhere?
b/c private set

H: yep

M: if someone is observing then goes
to grab adn get player name. Grab the occupation
and race, they're stale values? haven't updaet

H: taht is true.

M: what is a mitigating strategy there, for
making sure that don't accidentally let
someone jump the gun on making assumptions
about the consistency of the data as you
start updating incrementally your properties.

H: I think that is definitly one of the
challenges you have, the mitigating way
I try to hadnle that is be consistent
how I deal with these proeprties,
I wouldn't let any of my code observe
these things, that would become a code
smell if I saw something other than this
VM observing these other than my view.
Have to be diligent and be careful. Once
you start building a complex app with different
publishers and subscribers, it's going to be
going all over the place

why doing more of this and private set
of the publsiher. I can't prevent observing,
can prevent from setting. That would also
cause potential issues.

kNate - if this is on the main queue, would
that UI eleemnt, all would have changed
already.

H: the UIUPdates don't happen immediately,
so smart to batch up, your SUI will only
get updated once. That's not too bad,
if you're this player name, YMMV on what
may change.

I'm pretty sure if receiving on main
queue, it's going to dispatch that out,
so wouldn't get stale data in that case,
might be observing player name, but that
self?.property won't trigger subscriber
immediately.

Mikey: also seems like if there are three
pieces of information are never inconsistently
updated, coud make a small value type like player
info, and inside of receive value, make one
and assign it to that property, only one
subscriber fires.

H: important to keep in midnd, these
publsihd properies, you can get a publisher
right out of it.

can do $playerName.eraseToAnyPublisher()

that turns it into an any publsiher of type String, and
Never, so if need to do that, you can,
finding myself trying tonot to do that
per se and putting that source of truth up
a little bit, and having that be the
source of truth. Technically, in this aop,
tis is the source of truth for this view, and this view
only. If I'm observing this player name,
I'm not observing the real source of
truth - it's at the other end of that publisher.
When that changing getting notified. One 
of the things about SUI apps, gotta think
about what is my source of truth, and make
sure you're observing that, some artifact
of that.

Mikey: this is the text proeprty of a text
view, not of a model object.

H: got it.


Let's keep going, more to see here, 

Look at one other way might be interacting
with combine and view model.

Hey some souce of truth is changing, and
reformat for the view (earlier)

The StartGameViewModel (button) is
different.  Going to give this a 
passthrough subject. Give it aw ay
to send events to some other
place in our app.

private var events : PasthrougHSubejctM<UIVevent, Never>

Make sure the VM has a passthrough subject
(passed into that)

then in the start game is a 
events.send(.newGame)

Going to find this often - peices of 
code down in your view hierarchy, and the
source of truth is way up somewhere,
and you don't want to even have that
source of truth directly. In this case
this would be ugly for game has started.

I don;t know what needs to happen - I'll
delegate this out, almost the same asa
 delegate protocol, but using combine.

Nicer than using a deleagate, how you dealw ith
receiving these events and pass them around. Conceptually
is very like a delegate.

I'm going to send this, if someone's listening, great, if
not oh well.

The other ViewModels. Action bar works
similar - the same UIEvent, someone will pass in a
passthrough subject, one thing responding to 
different types of events.

PlayingFieldVM - marshaling out something coming in
and update heVM

Scoreboard is slightly different, the onky differnece here,
this has a child view model.

OutsVieWModel,has a way to set the value, a primitive
object. Id on't want to change its iterface for ahatever
reason. HAving this parenty view model, listen for
game updates, and then update both my proerpties an
dpas that along to a view model.

It is psossible where could (mikey) have a publisher
for the outs, and passed in a publisher for that
property into this child view.Could also use the
@Binding in SUI to do the same thing. Chose this for the
sake of the exmaple.  May have VMs that have to update
other VMs.  This outs VM and outsview is not
visible to this thing that is laoding the scoreboard
view. Once you're build view hierarhcies, find that
you need to pass things along to different view
models to get the data of where it should go.
Be mindful of the source of truth.  The source of truth
is not the outsViewModel, it's what's coming from the publsiher.

----

ContentViewModel

In the app - got our services. got our views, views
are connected to a view model. Now need somewhere that
glues them together.

some things you could here, like just one view model
that is that glue for this entire app. It's a small app
so this will work. You can work a coordiantor pattern
in another app, corodiantors that do this work, and
in the MVC architecture, this is the classic example
of a controller  Very little code in it, just taking 
different data sources, services, and connecting
them where they need to go.

A lot of different ways to architect this. but some
place has to connect all this stuff together.

HAve a publisher property for the Game that is afoot.
HAve view models for the primary views that this
view display.

This view has to craete other views and pass the view
models, acting like the glue. Very contrived example,
one big view is fine.  How can connect these view
models togethre.

This one also owns that events subject that you saw
passed in the UI events, the owner of that. (passthrough
subejct)

has the serivces, as ell as the gameLogicUpdate - holds
on to one of our subscribers that handles the game update.

All the fun stuff is in the init, first thing we do is 
go ahead and subcribe to any events that come from
the UIEvent publsiehr - (this is where the button events
come through).  Just subsbcirign. If any anysucced,
 it
calls something later on. (bork: need to revisit this)

adds this game logic service. current state of the
game, and as wing and update, eed to know current
team and batter - passing in the publsiher from the rosterService
(the sourec of truth for current team and batteR), so
pass a publsiher from the roster service into the game
lgoci service.  Connecting two services toegher.

I'm just erasing the type don't need the game logic
service, don't need the details.

crate start game view model, giving the events passthrough
the scoreboard view mode, using the $game, the source
of truth for the game, going to do a few tings,

$game.compactMap({$0}) - because game could be nil, so strip out
.eraseToAnyPublisher

So the scoreboard only cares about current gaem or current UI and
doesn't ahve to deal with an optional.  If game ever
goes nil ,teh scoreboard won't update - a downside of this

actionBarViewModel - similar,
for the nowBattingVM - this is interesting, it has to
take in a cople of differnet publsher. What I like to
do is crate a helper method, some of the operators can
get a little verbose -c reat ea little helper.

becaus the nowBattingVM - this is animportant concept.
It wants a Player. Doesn't want the name - wants the whole
player to cime in. But if look at the roster gives it, it's
giving us the name of the player. What we need to
do in order to make this work, is to transform that
string of a name intoa aplayer

rosterService.currentBatter.
flatMap { selfplayerINfoService.playerINfoService(playerName: $0) )}
.erase...

it takes the roster services current batter, poublisher
of type string.
calls flatmap - it takes a publisher, and then will
return a different kind of publisher. not _value_,
(map for that), but flatmap will take many publisher
sand turn into one. a lot it can do.

In this case, have that info service, that knows
how to go string -> publsiher of a player/error,
and so flatmapping over to that service, and this
creating a little structure, a little tiny pathway
string comes in, info service gets called, ma ybe
asyn, alld one, give player or error, and passing that whol
mechanism, whole publsiher into the now
batting view model
!!! (so pipelines without a sink. cool)

one of the thigns that is darn cool, and hence the name,
combingin these different publishers together to form
a publisher now that, this internal mechanism, and
hidden this all to the now batting VM. it doesn't
know how player came to be, or the complicated flow.

H: any questions?

The interesting thign abot now batting
VM>  Has this messagePublisher<String, Never>)
adds to list and keeps a certain amount.

The interesting thig, is two different sources
of messages.  One - the game logic gandalf hit a home
run, an the roster service when a new batter comes up to
bat, will send up a notification, Wnat to take those
two different sources of notifications and combine them
into one publsiher our VM can deal wiht,

have a mesagePublisher helper.

gameLgoicServicel.notifications.merge(with: rosterService.ntficiations)

merge lets us take two publsihers, combine them togehter,
and the output is an anypublisher of <String, Never>, using
merge in this way, a message comes in from either of these
two things, will be sent htrough this, little internal
machines, no natter how comes in, will come to the output.

make it easy to combine things.  Players and strings,
and it's al pretty easy.

One more little itneresting logic

The completion handler one - swing result service.

!!! What i'd like to do is wrap it in something that is
combine friendly. In this calse, wrote an extension and
added a SwingPublsiher, and return a publsiher of the
<SwingResult,Never>, and under the hoodl, making
a publisher, with a constructor that takes a future,
This is how you would wrap an async api. the nice thing,
is that when create the future, promsie callback,
call the existing API, and call the future callback ,with
a successful result.

When I sue this, don;t have to deal with the
completion handler, just treat it as a publisher,
because it now is.


What lets me do in batterSwing(), called by
method.  If there's a button that creates that batetr swing,
then doing 

self.gameLogicUpdate = swingResultServiceswingPublisher
  .receivE(onMain
   .flatMap { self.gameLogicSerice. (hadns tired)
but like the earlier publsiher.


[ ] Undo?  like the roster service
[ ] big UIKit app
[ ] debug strategies for a big web of publishers
  - print modifier, something to the log to tell something
    happening
  - that is a little bit of a warning flag, sometimes the
   gnarly setting breakpoints and using print and that
kind of thing.  WOuld also say in those cases, might
be need to encapsulate some of the machines together
into a class can reason more easily about, it;s every
easy to pass through teh app, and then get down,
and have no idea where the player came from.  As big as a
problem of all that. Make sure all the rest of the archtiectur
is coheisve, and not passing too many things around.

Unit testing is your friend. Unit testing with publsihers is
pretty great.  

writing a unit test that takes in publsihers, the game logic 
service, and what I'm doing, using Just to pass in statick valeus, 
isolate certain cases that I want and then test them,
the ncall the update method, that is returnign a publisher,
adn sinking, and doing expectaiton, like async code,
use expectations for this comine as well.

AHd this problem, a bug where I think players were staying
on second base, or never leave the field.  Very annoying
when it's sauron and he owns the world, wrote some
unit tests for soving the problem instantly,  

Use the Justs or Fails to set specific things you want to test
and use expetaitons really helps alot.

(Same kidn of pain points than notifications)
Can be easy to get into a spaghetti mess.  Be very
diligtent, consistent, and I wish you all the luck.

Q; Steven Holland - do you use Just publisher in privews,
have a problem getting them to render.

my previous talk talked about previews, you don't
want any kind of async thing to happen at all, it'll
be crazy. Usually in the work I've been doing in my
view model might 

MIkey: I think we recorded that session. not sure uploaded
it. If you help me rembmer, I'll do so
[ ] remind mikey :-)

H: also create some helper in my initilizer,
if I want to to buid int oa specific stae, and
make the publisher optional. That's a way of
doing previews.

Want to show another thing I do, is just create
an extension on this VM, 

extension ScoreBoardViewMOdel {
    static let someViewModel = ScoreVBoardVIewModel(goodScore: 42, badScore; 0)
}         

that I have this, in the preview do SocreBoardViewModel.someViewModel.

(and of course it doesn't work. #ilyxc)

WHat I'd further do, is multipel of these
jokers in the preview. I have a way to creat the
view model i na specific state w.o having to worry about
passing in Just - the VM created in that initial state.


preble: have pattern of pass in view models in the
enviroment - seems specific, feels like coming in to 
it initlaize a view pass in my serives that way.
Have you played iwth other approaches to the archteictur
here, and speak why you like that model vs others>

H: experiemnted a lot when SUI came out, and SUI2 came
out, with different approaches, I think the thing I lik
the env object approach

I could do an init(viewmodel), or pass in other things
to the view.  WIth the env object, I am being a little
bit lazy, b/c don't need an initizer that needs the type,
let the SUI env system deal with it. Ends up being helpful
if the child view, say a child view on this view also
needs access, it'll jsut be in the environment.

Want to go back, said somthing about services, and passing
services into the view, maybe I'm more opiniaonted. I don;t
want my view callign services. That is a lot harder
to test. b/c of the way I set this up, views are dumb,
so I can test all my views in previews just by passing
in different ytpes of view models, that creates a rapid
development enviroment w/o worrying about how data
wil lget to my view.  via env, could pass it in init
and that's fine, I just do it b/c that's one less bit
of code I have to deal with. I want the view to not
have that much logic in it b/c, the more logic in the
view, the more difficult it will be to test it.
no way to test SUI views direclty. No introspection,
maybe get that this year, but if I can test everything
up to this point, I can use previews to test if the display
will be what I want it to be,

I might change my mind in a month, this is all new.
I see people out there looking at different options ,and 
followign them what they do as well. Wanted to have
something opinionated.

Mikey: env objects in SUI, ahven't spend a ton of time,
that's only visible from that view now and its descendence,
not truy global, scoped truy global use that envrionemt key.
Should restirct to things like "dark mode" or do you put things
in?

H: some things you could possibly look at.  It worries
me. singletons and global state.  Rather, may be simplistic
in my thinking, if I have view, an the view has a view
mdoel ,and all comes from the VM, then don't need anything
else. Exceptions truly global things like size cls

[ ] remding mikey for this to give to MarcJ

[ ] folks followed to look at.

- Swift by Sundell
- watched a lot of twostraws. A lot of good info.
- watching to see what DaveDeLong and a few others
  that are eluding my name, some blogs.
TBH kind of picking out the stuff out of the watermelon
kind of thing "that's an interesting idea', not a lot
of folks doing deep blogs, wtatching how I can turn that
into 

(chat) CocoaWithLove too

Preble: say loading indicator -add that on a bool on viewmodel
if I'm currently loading

H: no :-)  Lemme share how to do that.

https://github.com/davidahouse/LOTRBall

for stuff like that, lemme find 

another repo - more complete architecture.
[ ]  get

what I've done, is have a BaseView, generic 
across what calling a BaseVieWMoel, abstracted view model
out even more, has a state enum, that has those states,
like loading, network error, or hey I got something
here's the data. I've done this in different aspects
instead of the view model in the LoTR where has propertesi,
it'll jsut have a state property, an enum that guards
the data relevatn to that state. and doing aswitchin
in your view is pretty simple to deal with.

my view, like most views, have to deal with, is the
success state, expliclty. loadign ane rror is generic
across all the views.

I spent about a long time at least over a year on this
architecutre, kept redoing it, delete everything, and rebuild
it back

not using combine as much as in hte LoTR example, and this
also uses a decision, on this app, to use UIKit
and SwiftUI together, have VCs and my view of the
view controller is all swift UI, and the VCs that deal
with navigation, b/c deal with navigation in SUI, you
gonna hit some bugs.  By using UIKit layer in there,
it prevents so many bugs. 

If you want to be purist, then you will ahve todel
with that. If yo uwant to dive into ti and are curious.

https://github.com/davidahouse/stampede-app

Mikey: thanks

next will be 5 weeks hence on May 13th.

Topic is TBA - let us know what want to hear.

