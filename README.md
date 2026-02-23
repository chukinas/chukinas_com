# Chukinas

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## WireCalc

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
- rename WireCalc -> Chukinas.Wiring
- ensure that the two below conduits compare correctly
     left:  #Conduit<emt 1 1/4>
     right: #Conduit<emt 1 1/2>
- rename priv/data to priv/national_electric_code
- Parse Wire (not just WireSpec)
- Conduit and WireSpec have a lot in common, but name-wise, Conduit is more similar to Wire.
- Conduit.round_count/1 - find out where this is mentioned in NEC, and maybe extract it to an appropriate module to document that.
