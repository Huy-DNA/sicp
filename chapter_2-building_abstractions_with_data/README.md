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
