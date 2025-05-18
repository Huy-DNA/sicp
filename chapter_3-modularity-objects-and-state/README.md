# Modularity, Objects, and State

We have seen:
- How primitive procedures & primitive data are combined to construct compound entities.
- Abstraction is vital to cope with the complexity of large systems.

However: These tools are not sufficient for program design! Effective program synthesis requires *organizational principles* that can guide us in *formulating the overall design of a program*.
-> We need techniques that can structure large systems in a *modular fashion* - they can be divided naturally into *coherent* parts that can be *separately developed and maintained*.

One powerful design strategy: Base the structure of our programs on the structure of the system being modeled.
- For each object in the system, we construct a corresponding computational object.
- For each system action, we define a symbolic operation in our computational model.
- Expectation: Adding new objects/actions will require no strategic changes to the program - only the addition of the new symbolic analogs of those objects or actions.
-> Based on our *perception of the system* to be modeled.
-> Two world views:
- *Object-centric*: View a large system as a collection of distinct objects whose behaviors may change over time.
  - Challenges:
    - How a computational object can change.
    - How an object maintain its identity.
  -> The substitution model of computation no longer works.
  -> More mechanistic but less theoretically tractable *environment model* of computation.
  -> The core issue is the need to grapple with time in the computational model.
- *Stream-centric*: Focus on the streams of information that flow in the system.
  - Decouple simulated time in our model from the order of the events that take place in the computer during evaluation.
  -> Technique: *delayed evaluation*.

