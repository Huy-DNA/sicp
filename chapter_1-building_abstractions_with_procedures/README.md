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
