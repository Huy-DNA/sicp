# Problem

Here is an alternative procedural representation of pairs. For this representation, verify that `(car (cons x y))` yields `x` for any objects `x` and `y`.

```scheme
(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))
```

What is the corresponding definition of `cdr`? (Hint: To verify that this works, make use of the substitution model of Section 1.1.5.)

# Answer

Verification that `(car (cons x y))` yields `x` for any object `x` and `y`:

  ```scheme
  (car (cons x y))
  (car (lambda (m) (m x y)))
  ((lambda (m) (m x y)) (lambda (p q) p))
  ((lambda (p q) p) x y)
  x
  ```

Corresponding definition of `cdr`:

  ```scheme
  (define (cdr z)
    (z (lambda (p q) q)))
  ```
