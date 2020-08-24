# My opinion on Aggregate Experiments.

## Classic aggregate root
This I like, its fairly streight forward to follow (once you get what AggregatRoot provides)
The events are hookup to the handlers in 1 place, which seems like an advantage and ensures you can build the state from the event payload.

## Extracted state example
Separating the state seems like a nice way to handle different ways of storing the state (if you are stuck with a relational db structure)

## Functional aggregate
I could hardly see the difference until the irb demo. Now I see how this might fit if the same event gets applied multiple times.

## Query based aggregate

## Aggregate Experiments - yield based aggregate (4:13)
N/A - did not quite grok this one, could've done with irb demo

## Polymorphic
First off I liked the explicite way the code looked, but it would not last long before someone DRY'ed it up
I do not like the CommandHandler being responsible for calling the aggregate and also publishing the events. How can you ensure the event has the correct data? (and is named and published consistently)

## Duck typing
I prefer this way of writing the code. I would say its only /just/ meta programming. You could use `#rescue NoMethoError` instead perhaps as an alternative.
