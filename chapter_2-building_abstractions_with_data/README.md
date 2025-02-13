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

#### Mapping over lists

- Mapping: The operation of applying some transformation to each element in a list and generate the list of results.

  ```scheme
  (define (map proc items)
    (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))
  ```

- Map is a very important construct:
  - Capture a common patten.
  - A higher level of abstraction in dealing with lists.

## Hierachical structures

- Tree: Sequence whose elements are sequences.
  - Branch: The element of the sequence.
  - Subtree: The element that are themselves sequences.

- Recursion is a natural tool for dealing with tree structures.

  ```scheme
  (define (count-leaves t)
    (cond ((null? t) 0)
          ((not (pair? t)) 1)
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))
  ```

### Mapping over trees

- `map` + recursion can be used to map over trees.

- Example `scale-tree`:

  ```scheme
  (define (scale-tree tree factor)
    (map (lambda (sub-tree)
           (if (pair? sub-tree)
               (scale-tree sub-tree factor)
               (* sub-tree factor)))
         tree))
  ```

- Other sequence operations + recursion can work too.

## Sequences as conventional interfaces

- *Conventional interfaces* is a powerful design principle for working with data structures.

- Consider the following 2 procedures:
 
  ```scheme
  (define (sum-odd-squares tree)
    (cond ((null? tree) 0)     ; iterate logic
          ((not (pair? tree))  ; iterate logic
           (if (odd? tree)     ; filter logic
             (square tree)     ; transform logic
             0))
          (else (+ (sum-odd-squares (car tree)) ; iterate & reduce logic
                   (sum-odd-squares (cdr tree)))))) ; iterate & reduce logic
  ```

  ```scheme
  (define (even-fibs n)
    (define (next k)
      (if (> k n) ; iterate logic
        nil
        (let ((f (fib k))
          (if (even? f) ; filter logic
            (cons f (next (+ k 1)) ; building-up-result logic & iterate logic
            (next (+ k 1)))))))) ; iterate logic
    (next 0))
  ```

- Common structure:
  - Enumerate something (leaves of a tree or values in a range).
  - Filter them.
  - Transform.
  - Accumulate results using `+`/`cons` starting with `0`/`null`.

  -> Analogy: Signal-flow

- The two procedure definitions fail to exhibit the signal-flow structure: enumeration, filtering, transformation, accumulation are all mixed up and scattered.

### Sequence operations

- Key: To organize the program to reflect better the signal-flow structure, we hoist the "signals" as the main entitie.

- Signals are really just sequences of values. We can represent signals as lists.

- Operations:

  - `map`: Described above.

  - `filter`:

    ```scheme
    (define (filter pred l)
      (cond ((null? l) null)
            ((predicate (car l))
             (cons (car l)
                   (filter pred (cdr l))))
            (else (filter pred (cdr l)))))
    ```

  - `accumulate`:

    ```scheme
    (define (accumulate op init l)
      (cond ((null? l) init)
            (op (car l)
                (accumulate op init (cdr l)))))
    ```

  - Enumeration:

    - Interval: `enumerate-interval`

      ```scheme
      (define (enumerate-interval low high)
        (if (> low high)
          null
          (cons low
                (enumerate-interval (+ 1 low) high))))
      ```
    - Tree: `enumerate-tree`

      ```scheme
      (define (enumerate-tree t)
        (cond ((null? t) null)
              ((not (pair? t)) (list t))
              (else (append (enumerate-tree (car t)
                            (enumerate-tree (cdr t)))))))
      ```

- Rewriting the above 2 procedures:

  ```scheme
  (define (sum-odd-squares tree)
    (accumulate + 0
      (map square
           (filter odd? (enumerate-tree tree)))))
  ```

  ```scheme
  (define (even-fibs)
    (accumulate cons null
      (filter even? (map fib (enumerate-interval 0 n)))))
  ```

  -> Modular design: Relatively independent pieces can be combined to more complex design.
  
  -> Encourage modular design by providng:
     - A library of standard components.
     - A conventional interface for connecting the components in flexible ways.

### Nested mappings

- Computations that are commonly expressed using *nested loops* can also be expressed using the sequence paradigm.

- Problem: Given a positive integer `n`, find all ordered pairs of distinct positive integers `i` and `j`, when `1 <= j < i <= n`, such that `i + j` is prime.

- Idea: Generate all pairs `(i, j)` such that `j < i` & Filter based on the primality of their sum.

- How to generate the pairs?

  1. Enumerate the interval `[1, n]`,
  2. For each number `i` in the interval, enumerate `[1, i]`.
  3. For each number `j` in the second interval, map it to `(i, j)`.
  4. Accumulate along the first interval using `append`.

```scheme
(accumulate
  append
  null
  (map (lambda (i)
         (map (lambda (j) (list i j))
           enumerate-interval 1 (- i 1)))
       (enumerate-interval 1 n)))
```

- `flatmap`: Abstract the combination of mapping and accumulating with `append`.

  ```scheme
  (define (flatmap proc seq)
    (accumulate append nil (map proc seq)))
  ```

- Prime-sum problem answer:

  ```scheme
  (define (prime-sum? pair)
    (prime? (+ (car pair) (cdr pair))))

  (define (prime-sum-pairs n)
    (filter prime-sum?
            (flatmap (lambda (i)
                       (map (lambda (j) (list i j))
                            enumerate-interval 1 (- i 1)))
                     (enumerate-interval 1 n))))
  ```

- Permutations of a set `S`:

  ```scheme
  (define (remove e s)
    (filter (lambda (x) (not (= x e)))
            s))
  (define (permutations s)
    (if (null? s)
      (list null)
      (flatmap 
        (lambda (e)
          (map
            (lambda (p) (cons e p))
            (permutations (remove e s))))
        s)))
  ```

### Example: A picture language

- A simple language for drawing pictures to showcase:
  - The power of data abstraction & closure.
  - Exploit the higher-order procedures in an essential way.
- The data objects are represented as procedurers rather than as list structure.

#### The picture language

- Checklist:
  - Primitive data structures: *painter*
    - An instance of which draws an image that is shifted and scaled to fit within a designated parallelogram-shaped frame.
    - Each "different" "primitive" instance draws a predefined image.
  - Means of combination: Operations that construct new painters from given painters to combine images.
    - `beside`: Takes two painters and produces a new painter that draws the first painter's image in the left half of the frame and the second painter's image in the right half of the frame.
    - `below`: Takes two painters and produces a compound painter that draws the first painter's image below the second painter's image.
    - `flip-vert`: Takes a painter and produces a painter that draws its image upside-down.
    - `flip-horiz`: Takes a painter and produces a painter that draws its image left-to-right reversed.
    - etc.
    
    -> The painters are closed under these operations.
  - Means of abstraction: Scheme procedures.

- Some abstractions:

  - `flipped-pairs`:

    ```scheme
    (define (flipped-pairs painter)
      (let ((painter2 (beside painter (flip-vert painter))))
        (below painter2 painter2)))
    ```

  - `right-split`: Take a painter and produce a painter that split horizontally in half by `n` times, draws the image in the left half each split, the right half of each split is split half vertically and both halves are continued to be splitted `n-1` times.

    ```scheme
    (define (right-split painter n)
      (if (= n 0)
        painter
        (let ((painter-rec (right-split painter (- n 1))))
          (beside painter (below painter-rec painter-rec)))))
    ```
    
  - `up-split`: Take a painter and produce a painter that split vertically in half by `n` times, draws the image in the lower half each split, the upper half of each split is split half horizontally and both halves are continued to be splitted `n-1` times.

    ```scheme
    (define (up-split painter n)
      (if (= n 0)
        painter
        (let ((painter-rec (up-split painter (- n 1))))
          (below painter (beside painter-rec painter-rec)))))
    ```

 - `corner-split`:
   
   ```scheme
   (define (corner-split painter n)
     (if (= n 0)
       painter
       (let ((left-painter (up-split painter n))
             (smaller-right-painter (right-split painter (- n 1)))
             (smaller-corner-painter (corner-split painter (- n 1))))
         (beside left-painter
                 (below (below smaller-right-painter smaller-right-painter)
                        smaller-corner-painter)))))
   ```

#### Higher-order operations

- Abstracting patterns of combining painter operations.

```scheme
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((upper-half (beside (tl painter) (tr painter))
          (lower-half (beside (bl painter) (br painter)))))
      (below lower-half upper-half))))
```

#### Frames

- A *frame* can be described by three vectors: an *origin vector* and two *edge vectors*.
  - *Origin vector*: The origin vector specifies the offset of the frame's origin from some absolute origin in the plane.
  - *Edge vectors*: The offsets of the frame's corners from its origin. If these two are perpendicular, the frame is a rectangle, otherwise, it's a parallelogram.
- Operations:
  - `origin-frame`: Selector for the origin vector.
  - `edge1-frame`: Selector for the first edge vector.
  - `edge2-frame`: Selector for the second edge vector.
- Images are specified using the coordinates in the unit square ($0 \le x, y \le 1$). Images are shifted and scaled to fit the frame using the *frame coordinate map* - a vector $(x,y)$ in the image is mapped to a point in the frame associated with the vector: $\text{Origin}(\text{Frame}) x \cdot \text{Edge}_1(\text{Frame}) + y \cdot \text{Edge}_2(\text{Frame})$.
```scheme
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame v)
      (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
                (scale-vect (ycor-vect v) (edge2-frame frame))))))
```

#### Painters

- A painter is represented as a procedure that takes a frame as an argument and fits & draws its image to the frame.
- Primitive painters are implemented depend on the graphics system and the type of image to be drawn.

```scheme
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (draw-line
          ((frame-coord-map frame)
           (start-segment segment))
          ((frame-coord-map frame)
           (end-segment segment))))
  segment-list)))
```

#### Transforming and combining painters

- Transforming painter by transforming the frame's origin and corners, `origin`, `corner1` and `corner2` are specified as points.

```scheme
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame new-origin
                             (sub-vect (m corner1) new-origin)
                             (sub-vect (m corner2) new-origin)))))))
```

- How to:
  - Flip vertically a painter:
    ```scheme
    (define (flip-vert painter)
      (transform-painter painter
                         (make-vect 0.0 1.0)
                         (make-vect 1.0 1.0)
                         (make-vect 0.0 0.0)))
    ```
  - Shrink the painter to the upper-right quarter of the frame:
    ```scheme
    (define (shrink-to-upper-right painter)
      (transform-painter painter
                         (make-vect 0.5 0.5)
                         (make-vect 1.0 0.5)
                         (make-vect 0.5 1.0)))
    ```
  - Rotate counter-clockwise by 90 degree a painter:
    ```scheme
    (define (rotate-90-counter-clockwise painter)
      (transform-painter painter
                         (make-vect 1.0 0.0)
                         (make-vect 1.0 1.0)
                         (make-vect 0.0 0.0)))
    ```
- Frame transformation also facilitates frame combination. For example, the `beside` combinator:
    ```scheme
    (define (beside painter1 painter2)
      (let ((left-painter (transform-painter painter1
                                             (make-vect 0.0 0.0)
                                             (make-vect 0.5 0.0)
                                             (make-vect 0.0 1.0)))
            (right-painter (transform-painter painter2
                                              (make-vect 0.5 0.0)
                                              (make-vect 1.0 0.0)
                                              (make-vect 0.5 1.0))))
        (lambda (frame)
          (left-painter frame)
          (right-painter frame))))
    ```

#### Levels of language for robust design

- Critical ideas of the picture language:
  - The fundamental data abstractions are specified using procedural representations.
  - The means of combination satisfy the closure property.
  - The tools for abstracting procedures can be used to combine painters in a more abstract way than the primitive combinators.
- *Stratified design*: A complex system should be structured as a sequence of levels that are described using a sequence of languages. A level is used as the primitive for the next level. The language used at each level of a stratified design has primitives, means of combination and means of abstraction appropriate to that level of detail.
- Pros: Make the programs robust - small changes in a specification will require correspondingly small changes in the program.

## Symbolic data

### Quotation

- The reason we have to quote symbols is to not confuse them with identifiers.
  - `(list a b)`: Construct a list of the *values* of `a` and `b`.
  - `(list 'a 'b)`: Construct a list of `a` and `b` themselves.
- Author's note:
  - Allowing quotation in a language makes it's harder to reason about: It destroys the notion that *equals can be substituted for equals*. Example: three is one plus two, but "three" is not "one plus two".
  - Quotation is powerful: It facilitates building expressions that manipulate other expressions.
- Symbols:
  ```scheme
  (define a 1)
  (define b 2)
  
  (list a b)   ; (1 2) 
  (list 'a 'b) ; (a b)
  (list 'a b)  ; (a 2)
  ```
- List:
  ```scheme
  '(a b c)     ; (a b c)
  '(* b (+ a)) ; (* b (+ a))
  '()          ; ()
  ```
  - Quotation mark violates the general rule that all compound expressions in our language should be delimited by parenthese and look like lists.
  - The special form `quote` can be used:
  ```scheme
  (quote a)    ; a
  (quote (a b c)) ; (a b c)
  ```
- `eq?`: Test whether 2 symbols are the same.
- `memq`: Take a symbol and a list, return the sublist beginning with the first occurence of the symbol. If the symbol is not in the list, `false` is returned.
   ```scheme
   (define (memq s l)
     (cond ((null? l) false)
           ((eq? s (car l)) l)
           (else (memq s (cdr l)))))
   ```

### Example: Symbolic differentiation

- Objective: Design a procedure that takes:
  - An algebraic expression
  - A variable
  and returns the derivative of the expression with respect to the variable.
- Example:
  - Input: $ax^2 + bx + c$ and $x$.
  - Output: $2ax + b$.
- Fun fact: Symbolic differentiation is one of the motivation of Lisp - a symbolic manipulation language.
- Idea:
  1. Define a differentiation algorithm that operates on abstract objects such as "sums", "products" and "variables".
  2. Define the representation for these abstract objects.

#### The differentiation program with abstract data

- Reduction rules:
  - $\frac{dc}{dx} = 0 \text{, for c a constant or a variable different from x}$
  - $\frac{dx}{dx} = 1$
  - $\frac{d(u+v)}{dx} = \frac{du}{dx} + \frac{dv}{dx}$
  - $\frac{d(uv)}{dx} = u\frac{dv}{dx} + v\frac{du}{dx}$ 
- Abstract data types:
  ```scheme
  (variable? e)             ; is e a variable?
  (same-variable? v1 v2)    ; are v1 and v2 the same variable?
  (sum? e)                  ; is e a sum?
  (adden e)                 ; addend of the sum e
  (augend e)                ; augend of the sum e
  (make-sum a1 a2)          ; construct the sum of a1 and a2
  (product? e)              ; is e a product
  (multiplier e)            ; multiplier of the product e
  (multiplicand e)          ; multiplicand of the product e
  (make-product m1 m2)      ; construct the product of m1 and m2
  ```
- Derivation procedure:
  ```scheme
  (define (deriv expr var)
    (cond ((number? expr) 0)
          ((variable? expr) (if (same-variable? expr var) 1
      0))
          ((sum? expr) (make-sum (deriv (adden expr) var
                                 (deriv (augend expr) var))))
          ((product? expr) (make-sum (make-product (multiplier expr) (deriv (multiplicand expr) var))
                                     (make-product (multiplicand expr) (deriv (multiplier expr) var))))
          (else (error "unknown expression type" expr))))
  ```
#### Representing algebraic expressions
- Variables are symbols:
  ```scheme
  (define (variable? x) (symbol? x))
  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))
  ```
- Sums and products are lists:
  ```scheme
  (define (make-sum a1 a2) (list '+ a1 a2))
  (define (make-product a1 a2) (list '* a1 a2))
  (define (sum? x) (and (pair? x) (eq? (car x) '+)))
  (define (addend x) (cadr x))
  (define (augend x) (caddr x))
  (define (product? x) (and (pair? x) (eq? (car x) '*)))
  (define (multipler x) (cadr x))
  (define (multiplicand x) (caddr x))
  ```
- Problem: The `deriv` result is unsimplified if using this implementation. This is complex to solve. One can choose to simplify at construction time (eagerly) or at selection time.

### Example: Representing sets

- Operations:
  - `union-set`: Union 2 sets
  - `intersection-set`: Intersect 2 set
  - `element-of-set?`: Check if an element is in the set
  - `adjoin-set`: Add an element to the set

#### Sets as unordred lists
- Representation: A list of its elements in which no element appears more than once. Empty set = Empty list.

```scheme
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? (car set) x) true)
        (else (element-of-set? (cdr set))))
```

```scheme
(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))
```

```scheme
(define (intersection-set s1 s2)
  (cond ((or (null? s1) (null? s2)) null)
        ((element-of-set? (car s1) s2) (cons (car s1) (intersection-set (cdr s1) s2)))
        (else (intersection-set (cdr s1) s2))))
```

```scheme
(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((element-of-set? (car s1) s2) (union-set (cdr s1) s2))
        (else (cons (car s1) (union-set (cdr s1) s2)))))
```

- When choosing a representation, we should be concerned of efficiency.
- For sets of size `n`, the time complexity of each operation is:
  - `element-of-set?`: Θ(n)
  - `adjoin-set`: Θ(n)
  - `intersection-set`: Θ(n^2)
  - `union-set`: Θ(n^2)

#### Sets as ordered lists

- Idea: Speed up set operations by ordering the set elements.

- `element-of-set?` can now stop if it encounters an element that's larger the desired element:
  ```scheme
  (define (element-of-set? x set)
    (cond ((null? set) false)
          ((equal? x (car set)) true)
          ((> (car set) x) false)
          (else (element-of-set? x (cdr set)))))
  ```
  Still Θ(n) but on average the steps are halved.
- `intersection-set` gains more impressive speedup:
  ```scheme
  (define (intersection-set s1 s2)
    (cond ((or (null? s1) (null? s2)) null)
          ((< (car s1) (car s2)) (intersection-set (cdr s1) s2))
          ((> (car s1) (car s2)) (intersection-set (cdr s2) s1))
          (else (cons (car s1) (intersection-set (cdr s1) (cdr s2))))))
  ```
  Θ(n) for two sets of size n.
- `adjoin-set`
  ```scheme
  (define (adjoin-set x set)
    (cond ((null? set) (cons x nil))
          ((< x (car set)) (cons x set)
          ((= x (car set)) set))
          (else (cons (car set) (adjoin-set x (cdr set))))))
  ```
  Still Θ(n) but on average the steps are halved.
- `union-set`
  ```scheme
  (define (union-set s1 s2)
    (cond ((null? s1) s2)
          ((null? s2) s1)
          ((< (car s1) (car s2)) (cons (car s1) (union-set (cdr s1) s2)))
          ((> (car s1) (car s2)) (cons (car s2) (union-set (cdr s2) s1)))
          (else (cons (car s1) (union-set (cdr s1) (cdr s2))))))
  ```
  Θ(n) for two sets of size n. 
