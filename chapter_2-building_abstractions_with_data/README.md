# Building abstractions with data

- The ability to construct compound data objects enables us to deal with data at a higher conceptual level than that of the primitive data objects of the language.

- Example: Rational numbers & the operation `add-rat` which computes the sum of two rationals
  - We can represent a rational number by 2 integers: a numerator and a denominator.
  - The operation `add-rat` would be implemented as 2 operations: One producing the numerator of the sum and one producing the denominator of the sum.
  -> It would better if we could "glue together" a numerator and denominator to form a pair (*coumpound data object*).
  -> We can regard rational number as a single conceptual unit.

- The use of *compound data* increases the modularity of programs:
  - We can treat a rational number as a whole instead of parts.
  - The part of our program that deals with rational numbers do not have to care about how the rational numbers may be presented.

- *Data abstraction*: The general technique of isolating the parts of a program that deal with *how data objects are represented* from the parts of a program that deal with how *data objects are used* is a powerful design methodology.

- Some key ideas:
  - *Data abstraction* enables us to erect suitable *abstraction barriers* between different parts of a program.
  - Prodedures alone can be used to form compound data, without any special "data" operations whatsoever. -> Blur the distinction between data and procedures.
  - *Closure* (a mathematical property) - The glue we use for combining data objects should allow us to combine compound data objects as well.
  - *Conventional interfaces* - A compound data object that can serve as an interface that allows multiple program modules to be combined in mix-and-match ways.
  - The choice of data representation can have significant impact on the time and space requirements of processes that manipulate the data.
  - *Generic operations* - Operations that must handle many different types of data/representations of data.
  - *Data-directed programming* - Allow individual data representation to be designed in isolation and combined *additively* (without modification).

## Introduction to data abstraction

- Procedure:
  - The details of how the procedure was implemented could be suppressed.
  - The particular procedure itself could be replaced by any other procedures with the same overall behavior.
  -> The analogous notion for compound data is called *data abstraction*.

- Basic ideas of *data abstraction*:
  - Structure the programs that are to use compound data objects so that they operate on "abstract data" or the programs should make no assumptions about the data.
  - A *concrete data representation* is defined independently of the programs that use the data.
  - The interface between these 2 parts of our system will be a set of procedures, called *selectors* and *constructors*, which implement the abstract data in terms of the concret representation.

## Example: Arithmetic operations for rational numbers

- Wishful thinking - The operations on abstract data:
  - `(make-rat <n> <d>)` returns the rational number whose numerator is `<n>` and denominator is `<d>`.
  - `(numer <x>)` returns the numerator of the rational number `<x>`.
  - `(denom <x>)` returns the denominator of the rational number `<x>`.

- Given these operations, we can implement arithmetic operations using this abstract model of rational numbers:

  ```scheme
  (define (add-rat r1 r2)
    (make-rat (+ (* (numer r1) (denom r2))
                 (* (numer r2) (denom r1)))
              (* (denom r1) (denom r2))))

  (define (sub-rat r1 r2)
    (make-rat (- (* (numer r1) (denom r2))
                 (* (numer r2) (denom r1)))
              (* (denom r1) (denom r2))))

  (define (mul-rat r1 r2)
    (make-rat (* (numer r1) (numer r2))
              (* (denom r1) (denom r2))))

  (define (div-rat r1 r2)
    (make-rat (* (numer r1) (denom r2))
              (* (denom r1) (numer r2))))

  (define (equal-rat? r1 r2)
    (= (* (numer r1) (denom r2))
       (* (numer r2) (denom r1))))
  ```

### Pairs

- Pairs enable us to implement the concrete level of the data abstraction.

- Later, pairs can be shown to be able to be built from procedures alone.

- Operations on pairs:

  ```scheme
  (cons <x> <y>)   ; construct a pair with `<x>` as the first element, `<y>` as the second
  (car <p>)        ; extract the first element of a pair `<p>`
  (cdr <p>)        ; extract the second element of a pair `<p>`
  ```

- A pair data object can be given a name and manipulated like a primitive data object.

  ```scheme
  > (define x (cons 1 2))
  > (car x)
  1
  > (cdr x)
  2
  ```

- Closure property: A pair can be constructed upon elements which are pairs itself.

  ```scheme
  > (define x (cons 1 2))
  > (define y (cons 3 4))
  > (define z (cons x y))
  > (car (car z))
  1
  > (car (cdr z))
  3
  ```

  -> Pairs can be used a general-purpose building blocks.

- *List-structured data*: Data constructed from pairs.

### Representing rational numbers

- We can represent a rational number as a pair of numerator and denominator:

  ```scheme
  (define (make-rat n d) (cons n d))
  (define (numer r) (car r))
  (define (denom r) (cdr r))
  ```

- This rational-number implementation does not reduce rational numbers to lowest terms.
  
  ```scheme
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  ```

## Abstraction barriers

- The underlying idea of data abstractions:
  - Identify a basic set of operations to work on the data objects.
  - This basic set of operations fuels all the possible interactions with the data objects.
  - Use only this set of operations on the data objects.

  -> Independent of the underlying representations.

- Example: Each of the horizontal lines is an *abstraction barrier*.

  ```
    -------[ Programs that use rational numbers ]-------
            Rational numbers in problem domain
    -------[ add-rat    sub-rat   ... ]-------
        Rational numbers as numerators and denominators
    -------[ make-rat   numer   denom ]-------
             Rational numbers as pairs
    -------[ make-rat   numer   denom ]-------
          However pairs as implemented
  ```

- Advantages: Make program easier to maintain and modify.

## What is meant by data?

- We implemented rationals using `make-rat` (constructor) and `numer` and `denom` (selectors).

- But it's not enough to say that a rational is whatever implemented by `make-rat` and `numer` and `denom`.

  We need to guarantee that if we construct a rational number `x` from a pair of integers `n` and `d` then extracting the `numer` and `denom` of `x` and dividing them should yield the same result as dividing `n` by `d`.

  -> `make-rat` and `numer` and `denom` must satisfy a set of conditions. In this case, if `x` is `(make-rat n d)` then

    $$
        \frac{(numer x)}{(denom x)} = \frac{n}{d}
    $$

- Data = A collection of constructors and selectors + A collection of conditions.

### Pair (another perspective)

- We can think of pair as:

  - A collection of constructors and selectors:

    ```scheme
    (cons first second)  ; construct a pair with `first` and `second`
    (car pair)           ; select the first element of a pair
    (cdr pair)           ; select the second element of a pair
    ```
  
  - A collection of conditions:

    ```scheme
    (car (cons first second))  ; should be `first`
    (cdr (cons first second))  ; should be `second`
    ```
- An implementation of `pair` (out of procedures alone):

  ```scheme
  (define (cons first second)
    (define (dispatch m)
      (cond ((= m 0) first)
            ((= m 1) second)
            (else (error "Argument not 0 or 1: CONS" m))))
    dispatch)

  (define (car z) (z 0))
  (define (cdr z) (z 1))
  ```

  -> It's possible to to have a procedural representation of pairs.

  -> This style is called "message passing".

### Extended exercise: Interval Arithmetic

- Problem: Create a data type and a set of operations for manipulating inexact quantities with known precision. This is called an "interval" type and we want to manipulate "interval"s.

- An interval has two endpoints: a lower-bound and an upper bound.

- Set of operations: `make-interval`, `upper-bound`, `lower-bound`.

- `add-interval`, `mul-interval`, `div-interval`:

  ```scheme
  (define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))
  (define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4))))
  (define (div-interval x y)
      (mul-interval
        x
        (make-interval (/ 1.0 (upper-bound y))
                       (/ 1.0 (lower-bound y)))))
  ```

- There's a bug in `div-interval` procedure, in that in actuality, dividing by an interval that spans `0` doesn't result in an interval!

- Relate exercises: See 2.7 - 2.16

## Hierarchical data and the closure property

- Pairs can be visualized using the *box-and-pointer* notation:

  - Each object is a *pointer* to a box.
  - A box for a primitive object contains a representation of the object.

  A box can be another pair. -> The *closure property*.

- *Closure property*: The property of a data combination operation in which the result of such operation can be themselves combined using that same operation.

  -> Permit us to create *hierarchical* structures - structures that are made of parts, which are made up parts, and so on.

### Representing sequences

- Sequences can be represented using pairs.

- List: Nested `cons`es.

  ```scheme
  (cons <a1>
  (cons <a2>
      (cons <a3>
      (cons <a4>
          (...
          (cons <an> nil>)...)))))
  ```

- The `list` primitive:

  ```scheme
  (list <a1> <a2> ... <an>)
  ```

#### List operations

- The procedure `list-ref` takes as arguments a list and a number `n` and returns the `n`th item of the list:

  - For `n = 0`, `list-ref` should return the `car` of the list.
  - Otherwise, `list-ref` should return the `(n-1)`st item of the `cdr` of the list.

  ```scheme
  (define (list-ref list n)
    (if (= n 0)
        (car list)
        (list-ref (cdr list) (- n 1)))
  ```

- The procedure `length` returns the length of a list.

  ```scheme
  (define (length list)
    (if (null? list)
      0
      (+ 1 (length (cdr list)))))
  ```

- The procedure `append` takes two lists as arguments and combines their elements to make a new list:

  ```scheme
  (define (append l1 l2)
    (if (null? l1)
      l2
      (cons (car l1) (append (cdr l1) l2))))
  ```

  Technique: `cons`-up the answer list & `cdr`-down a list.
