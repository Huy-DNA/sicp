# Building abstractions with procedures

- Computational process: One that executes programs to answer questions/affect the world.
- Program: A pattern of rule to direct the _evolution_ of a process.
- Programming language: To express our procedural thoughts as a pattern of rule (program) just like mathematical notations aid in mathematical reasoning.

> Why Lisp?

- Lisp: LISt Processing

- History context:
  - Lisp is conceived of by John McCarthy.
  - Lisp was invented in the laste 1950s as a formalism for reasoning about the use of recursion equations as a model for computation.
  - Lisp was designed to provide symbol manipulating capabilities for programming problems such as symbolic differentiation and integration of algebraic expressions.
    For this purpose, it includes new data objects known as _atoms_ and _lists_.

- Philosophy: Lisp was not the product of a concerted design effort.
  - It evolved _informally_ in an experimental manner in response to users' needs and to pragmatic implementation considerations.
  - The community of Lisp users has traditionally resisted attempts to promote any official definition of the language.
  - Due to this informality, Lisp is by now a family of dialects.
  - Due to the emphasis on symbol manipulation, Lisp was very inefficient for numerical computation. This has been mitigated throughout the years, although Lisp still hasn't overcome its old reputation as hopelessly inefficient.

- Lisp has unique features that is execellent for studying:
  - Important programming constructs & data structures.
  - Linguistic features that support them.

- Most significant feature of Lisp: Its descriptions of processes, called procedures, can be represented as Lisp data.
  Lisp is an execellent language for writing programs that must manipulate other programs as data.

## The elements of programming

- A programming language should serve as a framework within which we organize our ideas about processes instead of just a means for instructing computer.
  This means we should view the programming language features from a _pragmatic_ viewpoint instead of just a _syntactic_ or a _semantic_ viewpoint.

- When describing a language, we should pay attention to how the language facilitates combining simple ideas to form more complex ideas.

- Every powerful language has 3 mechanisms for accomplishing this:
  - *primitive expressions*, the simplest entities the language is concerned with.
  - *means of combination*, by which compound elements are built from simpler ones.
  - *means of abstraction*, by which compound elements can be named and manipulated as units.

- Two kinds of elements in programming: *procedures* and *data*.
  - Data: Stuff we manipulate.
  - Procedures: Descriptions of the rules for manipulating the data.

### Expressions

- Lisp uses a prefix notation called S-expression.
- Lisp obeys the convention that every expression has a value.
  A _special form_ in Lisp breaks out of this convention.

```scheme
(/ 10 5)
(+ 2.7 10)
(* (- 2 3) (+ 3 5))
```

- Combination: Expression formed by delimiting a list of expressions within parentheses in order to denote procedure application.
- Operator: Leftmost element in the list.
- Operand: The remaining elements in the list.
- Value of combination is obtained by applying the procedure _specified by the operator_ to the _arguments_ that are values of the operands.

## Naming and the environment

- An important aspect of a programming language is using _names_ to refer to _computational objects_.
  The _name_ is said to _identify_ a _variable_ whose _value_ is the _object_.

- In Scheme, `define`  is a special form for naming things.

```scheme
(define size 2)
```

- Naming is the simplest means of abstraction (in Scheme).

- The interpreter must maintain some memory to keep track of the name-object pairs, called the _environment_.

## Evaluating combinations

- To evaluate a combination, do the following:
  1. Evaluate the subexpressions of the combination.
     The operator should evaluate to a procedure.
     The others evaluate to values of arguments.
  2. Apply the procedure to the arguments.

- The evaluation rule is recursive in nature: Evaluating an expression requires evaluating its subexpressions.

- Tree accumulation.

- Syntactic sugar: Special syntax forms that are convenient alternative _surface_ structures for things that can be written in _more uniform_ ways.

- Lisp programmers are less concerned with matters of syntax because Lisp is flexible to change surface syntax.

- Many convenient syntactic constructs actually make the language less uniform.

## Compound procedures

- Procedure definition: Another abstraction technique.

```scheme
(define (<name> <formal parameters)
  <body>)
```

- Note that these two are different:

```scheme
(define x1 2)
(define (x2) 2)
```

- `x1` is the name for the value `2` and `x2` is a procedure that returns `2` when calling like this `(x2)`.

## The substitution model for procedure application

> How to evaluate a combination whose operator names a compound procedure?

- *Substitution model*: To apply a compound procedure to its argument, evaluate its procedure with each formal parameter replace by the corresponding argument.

- The substitution model is just a model to visual process application, not enforcing how the interpreter should work.

- There are other elaborate models of how interpreters work.

## Applicative order versus normal order

- Normal-order evaluation: "Fully expand and then reduce" - arguments are not evaluated immediately but being substituted into a procedure body first.

- Applicative-order evaluation: Evaluate the arguments and then apply. Also known as call-by-value order of redex reduction.

- For procedure applications that can be modeled using the substitution model and yield legitimate values, applicative-order evaluation and normal-order evaluation produce the same value.

- Lisp uses applicative-order evaluation because:
  - Additional efficiency.
  - Normal-order evaluation becomes unwiedly complicated outside the realm of procedures that can be modeled by substitution.

## Conditional expressions and predicates

- The special form `cond`:

```scheme
(cond (<p1> <e1>)
      (<p2> <e2>)
      ...
      (<pn> <en>))
```

- Clause: The pair `(<p> <e>)`.
  - *Predicate*: The first expression in each pair.
  - *Consequent expression*: The second epxression in each pair. It can be a sequence of expressions.

- The special form `if`:

```scheme
(if <predicate> <consequent> <alternative>)
```

- `<consequent>` and `<alternative>` must be single expressions.

## Example: Square roots by Newton's Method

- There's an important difference between mathematical functions and computation procedures: Prcedures must be _effective_.

- Mathematical functions are _declarative_ but procedures are _imperative_.
  A mathemetical's definition of the square root operation written in a pseudo-Lisp:
  ```scheme
  (define (sqrt x)
    (the y (and (>= y 0)
                (= (square y) x))))
  ```

- Compute square roots using Newton's method of successive approximation: [Link](newton_square_root.rkt)

# Procedures and the processes they generate

- Programming = Planning the course of actions to be taken by a process via means of a program.

- Procedure = pattern for the _local evolution_ of a computational process.

- We would like to reason about the _global behavior_ of a procedure thou.

## Linear recursiong and iteration

- A factorial function that generates a _linear recursive_ process:
  ```scheme
  (define (factorial n)
    (if (= n 0)
      1
      (* n (factorial (- n 1)))))
  ```

  This one generates a process like this:
  ```scheme
  (factorial 6)
  (* 6 (factorial 5))
  (* 6 (* 5 (factorial 4)))
  (* 6 (* 5 (* 4 (factorial 3))))
  (* 6 (* 5 (* 4 (* 3 (factorial 2)))))
  (* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
  (* 6 (* 5 (* 4 (* 3 (* 2 (* 1 (factorial 0)))))))
  (* 6 (* 5 (* 4 (* 3 (* 2 (* 1 1))))))
  (* 6 (* 5 (* 4 (* 3 (* 2 1)))))
  (* 6 (* 5 (* 4 (* 3 2))))
  (* 6 (* 5 (* 4 6)))
  (* 6 (* 5 24))
  (* 6 120)
  720
  ```

  A shape of expansion followed by contraction:
  - Expansion builds up a chain of deferred operations.
  - Contraction occurs as the operations are actually performed.
  -> A _recursive process_

  There are hidden information inside the interpreter that keeps track of where we are in the process. The amount of information needed to keep track of the process grows linearly with `n`.
  -> A _linear recursive process_

- A factorial function that generates a _linear iterative_ process:
  ```scheme
  (define (factorial n)
    (define (iter i product)
      (if (= i 0)
        product
        (iter (- i 1) (* product i))))
    (iter n 1))
  ```

  This one generates a process like this:
  ```scheme
  (factorial 6)
  (iter 6 1)
  (iter 5 6)
  (iter 4 30)
  (iter 3 120)
  (iter 2 360)
  (iter 1 720)
  (iter 0 720)
  720
  ```
  
  This one does not grow or shrink.
  -> An _iterative process_.

  An iterative process's state can be summarized by a fixed number of _state variables_.

  The number of steps grows linearly with `n`.
  -> A _linear iterative process_.

- A recursive procedure can generate an iterative process.

- C, Ada, Pascal have to resort to looping constructs to desribe iterative processes; Recursive procedures there always have their interpretation consuming resources which grow linearly with the number of procedure calls.

- Scheme is different, it will execute an iterative process in constant space even if it's described a recursive procedure. -> An implementation with this property is called _tail-recursive_.

- In a _tail-recursive_ implementation, special iteration constructs can be considered syntactic sugar.

## Tree recursion

- A recursive-process-yielding procedure for calculating the `n`th fibonacci number:

  ```scheme
  (define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1))
                   (fib (- n 2))))))
  ```

  This yields a tree-recursive process.
  - The steps taken grows linearly with the total number of nodes in the tree (which is exponential with the input).
  - The space required grows linearly with the depth of the tree.
  
  ```scheme
                                                    (fib 5)
                            (fib 3)                                             (fib 4)
                (fib 1)                  (fib 2)                   (fib 2)                     (fib 3)
                                 (fib 0)         (fib 1)     (fib 0)      (fib 1)      (fib 1)        (fib 2)
                                                                                                (fib 0) (fib 1)
  ```

- An interative-process-yielding procedure for calculating the `n`th fibonacci number:

  ```scheme
  (define (fib n)
    (define (fib-iter rounds fib-i-2 fib-i-1)
      (if (= rounds 0)
        fib-i-1
        (fib-iter (- rounds 1) fib-i-1 (+ fib-i-1 fib-i-2))))
    (fib-iter n 1 0))
  ```

- Although the iterative version is more efficient, the recursive version is more straightforward, allowing for a direct translation to Lisp.

### Example: Counting change

- Problem: How many different ways can we make change of $1.00, given half-dollars, quarters, dimes, nickels, and pennies? More generally, can we write a procedure to compute the number of ways to change any given amount of money?

- See [Link](count_change.rkt)

- In the above solution, we implement a tree-recursive version. We note that it's not obvious how to design a better algorithm.

- Tree-recursive: Higher inefficient, but easy to specify & understand.

  People have proposed one could get the best of both worlds by designing a "smart compiler" that could tranform tree-recursive procedures into more efficient procedures that compute the same result. One approach is _tabulation_ or _memoization_.

## Orders of growth

- The notion of _order of growth_ can be used to obtain a gross measure of the resources required by a process as the inputs become larger.

- Let `n` be a parameter that measures the size of the problem & `R(n)` be the amount of resources the process requires for a problem of size `n`: `R(n)` is said to have order of growth `Θ(f(n))` or `R(n) = Θ(f(n))` if `k1 f(n) <= R(n) <= k2 f(n)` for any sufficiently large value of `n`.

## Exponentiation

- Problem: Compute the exponential of a given number: base `b` and a positive integer exponent `n`.

- Naive idea:

  $$b^n = b \cdot b^{n - 1}$$

  $$b^0 = 1$$

  Linear recursive: [Link](linear-recursive-exponentiation.rkt) - `Θ(n)` steps and `Θ(n)` space.

  Linear iterative: [Link](linear-iterative-exponentiation.rkt) - `Θ(n)` steps and `Θ(1)` space.

- Better idea:

  $$b^{n} = (b^{\frac{n}{2}})^2 \text{if n is even}$$

  $$b^{n} = b \cdot (b^{\frac{n - 1}{2}})^2 \text{if n is odd}$$

  Grow logarithmically with `n` in both space and number of steps: [Link](logarithmic-recursive-exponentiation.rkt)

Remark: From the exercises 1.16 to 1.18, I have formed 2 thought frameworks for devising recursive and linear processed-yield procedures:

  - Recursive version: Come up with an induction formula and directly translate it.

  - Linear version: Try to think of an invariant.

## Greatest common divisors

- Greatest common divisor of two integers `a` and `b` is the largest integer that divides both `a` and `b` with no remainder.

- Euclid's algorithm: [Link](euclide-algorithm.rkt)

  Idea: If `r <- a mod b` then $GCD(a, b) = GCD(b, r)$.

  According to Lamé's theorem, the order of growth is `Θ(log n)`.

## Example: Testing for primality

### Searching for divisors

- Searching from `1` to `sqrt(n)` for a divisor of `n`:

  ```scheme
  (define (divides? a b) (= (remainder b a) 0))

  (define (prime? n)
    (define (find-divisor start-divisor)
        (cond ((> (* start-divisor start-divisor) n) n)
              ((divides? start-divisor n) start-divisor)
              (else (find-divisor (+ start-divisor 1)))))
    (= (find-divisor 2) n))
  ```

- An iterative process with `Θ(sqrt(n))` order of growth.

### The Fermat test

- The Fermat test is a `Θ(log n)` primality test, which is basd on the Fermat's Little Theorem:

  > If `n` is a prime number and `a` is any positive integer less than `n`, then `a` raised to the nth power is congruent to a modulo `n`.

- Idea: If `n` is not prime, then, in general, most of the numbers `a < n` will not satisfy the above relation.

- Algorithm: Given a number `n`, we repeatedly pick a random number `a < n`:
  - Compute the remainder of `a^n modulo n`.
  - If it is not equal to `a`, then `n` is certainly not prime.
  - If it is `a`, then there is a high chance that `n` is prime.
  -> By trying more and more values of `a`, we can be more confident in the result.

- The exponentiation (modulo a base) algorithm is similar to the exponentiation algorithm introduced in the previous section, which is `Θ(log n)`.

  ```scheme
  (define (fast-exp base exp n)
    (define (exp-iter i)
      (cond ((= i 0) 1)
            ((even? i) (remainder
                        (square (exp-iter (/ i 2)))
                        n))
            (else (remainder
                   (* base
                      (square (exp-iter (/ (- i 1) 2))))
                   2))))
    (exp-iter exp))
  ```

  Assume that `random` is a primitive procedure:

  ```scheme
  (define (fermat-test n)
    (= n
       (fast-exp (+ 1
                    (random (- n 1)))
                 n
                 n)))
  ```

  ```scheme
  (define (fast-prime n times)
    (cond ((= times 0) true)
          ((fermat-test n) (fast-prime n (- times 1)))
          (else false)))
  ```

### Probabilistic methods

- The Fermat test is a probabilistic algorithm - the answer we obtain is probably correct.

- If we run the test enough times, the probability of error can be made as small as we like.

- However, the Fermat test can be fooled: there exist non-prime numbers but `a^n` is congurent to `a` modulo `n` for all integers `a < n` (Carmichael number). These numbers are extemely rare to the point that "in testing primality of very large numbers chosen at random, the chance of stumbling upon a value that fools the Fermat test is less than the chance that cosmic radiation will cause the computer to make an error in carrying out a “correct” algorithm".

- There are variations of the Fermat test that cannot be fooled.

- _Probabilitic algorithm_: One that the chance of error can be proved to become arbitrarily small.

# Formulating abstractions with higher-order procedure

- Procedures are abstractions that describe operations on parameters that are independent from particular arguments.

- Without procedures, we're forced to always work with the primitive operations of a language.

```scheme
(define (cube x) (* x x x))
; vs
(* 3 3 3)
(* x x x)
(* y y y)
```

- Often we need to repeat the same programming pattern many times - procedures that manipulate other procedures or _higher-order procedures_ can help express a programming pattern.

## Procedures as arguments

- Example 1: Sum of integers from a to b.

```scheme
(define (sum-integers a b)
  (if (> a b)
    0
    (+ a (sum-integers (+ a 1) b))))
```

- Example 2: Sum of cubes of integers from a to b.

```scheme
(define (sum-integers a b)
  (if (> a b)
    0
    (+ (cube a)
       (sum-integers (+ a 1) b))))
```

- Example 3: Sum of a sequence of terms in the series - $\frac{1}{n \cdot (n+2)}, n \ge 1$, which coverges to $\pi / 8$.

```scheme
(define (pi-sum a b)
  (if (> a b)
    0
    (+ (/ 1.0 (* a (+ a 2)))
       (pi-sum (+ a 4) b))))
```

- These 3 share a common programming patterns:

  ```scheme
  (define (⟨name⟩ a b)
    (if (> a b)
      0
      (+ (⟨term⟩ a)
         (⟨name⟩ (⟨next⟩ a) b))))
  ```

  -> An indication that some useful abstraction awaits.

- Higher-order procedure example:

  ```scheme
  (define (sum term a next b)
    (if (> a b)
      0
      (+ (term a)
         (sum (next a) b))))
  ```

- Integral can be built on top of `sum`, we just have to pass a function that slowly increments `a` to `next`:

  $$\int_a^b f(x) \, dx = \left[ f\left(a + \frac{\Delta x}{2}\right) + f\left(a + \Delta x + \frac{\Delta x}{2}\right) + f\left(a + 2\Delta x + \frac{\Delta x}{2}\right) + \cdots \right] \Delta x$$

  ```scheme
  (define (integral f a b dx)
    (define (add-dx x)
      (+ x dx))
    (* (sum f a add-dx b)
       dx))
  ```
