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

## Assignment and local state

- The world is populated by independent objects, each *has a state* that change over time.
- An object is said to *have state* if its behavior is influenced by its history.
- The state of an object is characterizable by one or more *state variables*, which maintain enough information about history to determine the object's current behavior.
- Objects may influence the state of the others through *interactions* to couple the state variables of one object to those of other objects.
- This view is mostly useful when the state variables of the system can be grouped into *closely coupled subsystems* that are only *loosely coupled* to other *subsystems*.
- To model state variables using symbolic names, the programming language must provide an *assignment operator* to change the value associated with a name.

### Local state variables

- Example of time-varying state:
  ```scheme
  (withdraw 25)
  75
  (withdraw 25)
  50
  (withdraw 60)
  "Insufficient funds"
  (withdraw 15)
  35
  ```
  -> New behavior: `(withdraw 25)` returns different results with the two calls.
  ```scheme
  (define balance 100)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  ```
- Special form:
  ```scheme
  (set! <name> <new-value>)
  ```
- Special form:
  ```scheme
  (begin <exp1> <exp2> ... <expk>)
  ```
  evaluates the expressions in order and return the value of the final expression.
- Encapsulate the local state:
  ```scheme
  (define new-withdraw
    (let ((balance 100))
      (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (-balance amount))
                   balance)
            "Insufficient funds"))))
  ```
  -> Hiding principle.
- Object constructor:
  ```scheme
  (define (make-withdraw balance)
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds")))
  ```
- Bank account object:
  ```scheme
  (define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                    balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (define (dispatch m)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request: MAKE-ACCOUNT"
                            m))))
    dispatch)
  ```
  -> Message-passing style.

### The benefits of introducing assignment

- Assume a procedure `rand-update` that has the property that if we start with a given number $x_1$ and form

```scheme
x2 = (rand-update x1)
x3 = (rand-update x2)
```
then the sequence of values will have the desired statistical properties.

- Using local state variable to implement `rand`:

```
(define rand (let ((x random-init))
                (lambda ()
                    (set! x (rand-update x))
                    x)))
```

- Alternative scheme: Use `rand-update` directly -> Annoying as any part of the program has to remember the current value of `x`.

- Monte Carlo method:
  - Choose sample experiments at random from a large set.
  - Estimate probabilities from tabulating the results of those experiments.
  - Make deductions on the basis of those probabilities.
- Estimate π: we perform a large number of experiments. In each experiment we choose two integers at random and perform a test to see if their GCD is 1. The fraction of times that the test is passed gives us our estimate of 6/π^2, and from this we obtain our approximation to π.
- Monte Carlo:
  ```scheme
  (define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
      (cond ((= trials-remaining 0)
             (/ trials-passed trials))
            ((experiment)
             (iter (- trials-remaining 1)
                   (+ trials-passed 1)))
            (else
             (iter (- trials-remaining 1)
                   trials-passed))))
    (iter trials 0))
  ```
- Estimate π using Cesaro's test:
  ```scheme
  (define (estimate-pi trials)
    (sqrt (/ 6 (monte-carlo trials cesaro-test))))
  (define (cesaro-test)
    (= (gcd (rand) (rand)) 1))
  ```
- Using `rand-update` directly: Less modularity.
  ```scheme
  (define (estimate-pi trials)
    (sqrt (/ 6 (random-gcd-test trials random-init))))
  (define (random-gcd-test trials initial-x)
    (define (iter trials-remaining trials-passed x)
        (let ((x1 (rand-update x)))
            (let ((x2 (rand-update x1)))
                (cond ((= trials-remaining 0)
                       (/ trials-passed trials))
                      ((= (gcd x1 x2) 1)
                       (iter (- trials-remaining 1)
                             (+ trials-passed 1)
                             x2))
                      (else
                        (iter (- trials-remaining 1)
                              trials-passed
                              x2))))))
    (iter trials 0 initial-x))
  ```
  - The random number generator is leaking out: `estimate-pi` has to supply in an initial random number.
- (?) By introducing assignment and the technique of hiding state in local variables, we are able to structure systems in a more modular fashion. (NOT CORRECT)
