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

