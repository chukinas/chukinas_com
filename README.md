# Chukinas

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Chukinas.Wiring

A set of tools for increasing the efficiency of electical estimating.

### Planned Tools

Right now, this is just a work in progress.
But I do anticipate getting the following up and running:

- Conduit Fill Calculator - answers the question "What's the smallest conduit that can hold a given set of wires"
- De-rating Calculator - when too many circuits are ran in the same conduit, the wires will heat up more.
  To combat this, you must use larger wire to reduce the resistance, and bring the temperature down.
  This calculator provides that answer.
- Voltage Drop - This is the other reason you have to increase your wire size.
  The longer your "homerun" (from breaker panel to device), the move voltage you lose at your device.
  This tool tells you how far to up-size your size to keep voltage drop within acceptable limits.

### Don't these tools already exist?

Well, yes and no.
You can visit the Southwire website and find pieces of the answer above.
But nowhere do you have a complete solution that is friendly to **cost estimators**.
We estimators need to make quick, "good enough" decisions in order to quickly and accurately price a job.
Having excellent tools like this make the job faster.
The Southwire tools make you do too much data entry.
For example, I almost NEVER need to specify that I'm using copper wire or THHN insulation, since that's our default.
My tools reduce touchpoints to an absolute minimum to make it as fast as possible.
Another example: their conduit fill calculator forces you to enter the conduit size.
The tool then gives you a "score" for that conduit size.
But we almost never care about the score for any given conduit.
All **we** want to know is: given our wire, **what size** conduit do I use?

### TODO

- on save: mix format
- Parse Wire (not just WireSpec)

## Chukinas.BidTracker

### Next Steps

- browser title: rm " * Phoenix Framework"
- add in documentation
- add an "add" btn (don't display all the dummy data at first; only the first 10. then when adding one, we pull from the list)
- ActiveBid struct
- When screen is too narrow, Project Name shouldn't disappear.
- pause genserver interactions for rand ms
- add "Edit dialog" for active bids
- add typedstruct (by adding the previous Event struct from TSR)
- add an "add new" button


### Current commit
- delete button should use events


### Knocking the Rust off
- how to move a vim line up or down
- how to open new terminal window using the same current path
- git fugitive: create a new branch, show branches, switch branches
- vim: how quickly pick from buffer list
- vim: I know that `O` moves me back through the (what's it called) list. How do I go back fwd through it though?
- vim: show the buffer list

## Chukinas.Messbugg

- Owner
  - add tests
  - What is this actually called in event sourcing?
