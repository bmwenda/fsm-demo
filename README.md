# Finite State Machine (FSM) Demo

## Introduction
This is a brief demo of a finite state machine. A finite state machine is an [abstract machine](https://en.wikipedia.org/wiki/Abstract_machine) that can be in exactly one of finite states at any given time.

A finite state machine can only change from one state to another by accepting an input. This is called a **transition**

### Examples
There are many examples of finite state machines in real life, among them vending machines, turnstiles, elevators, traffic lights, combination locks and so on.

## Implementation
The best way to implement an FSM is to make use of the [State Design Pattern](https://www.geeksforgeeks.org/state-design-pattern). Generally, we need to have a context class that knows what the current state is and the state class that defines how states should be transformed (transitions).

In ruby, several gems exist to implement FSMs with the most popular ones being [state machines](https://github.com/state-machines/state_machines) and [aasm](https://github.com/aasm/aasm)(acts as state machine).

In this example, I have used aasm.

## Explanation
In this demo, I am using a state machine to manage states of a spacecraft [Dragon](https://en.wikipedia.org/wiki/Dragon_2) that can launch, dock to the ISS and return to earth.

The aasm gem has a simple and intuitive DSL that allows us to define states and events within an `aasm` block.
With that, we can define all the possible states of the spacecraft and the events required to transition from one state to another.

Note that stransitions should be sequential in an FSM. For example, an elevator cannot skip floors. This is where libraries come in handy because they manage these checks which would otherwise be very cumbersome to do.

**Example**
```
dragon = Dragon.new

# Initial state
dragon.docking? #=> true

# Next state
dragon.may_launch? #=> true

dragon.launch #=> true

# Docking
dragon.may_dock? #=> false

dragon.dock
AASM::InvalidTransition Exception: Event 'dock' cannot transition from 'launching'
```
The last check fails because you cannot skip states. Dragon cannot dock from launch, it can only dock after deploying.
Aasm raises exceptions for such invalid transitions.

```
# Deploy
dragon.may_deploy? #=> true
dragon.deploy #=> true

# Ready to dock
dragon.may_dock? #=> true
```
After deploying, we can now dock to station.

## References and further reading
1. [Finite state machines](https://en.wikipedia.org/wiki/Finite-state_machine)

2. [Automata theory](https://en.wikipedia.org/wiki/Automata_theory)

3. [State pattern](https://medium.com/datadriveninvestor/state-machine-design-pattern-part-2-state-pattern-vs-state-machine-3010dd0fcf28)
