# Problem

In case representing pairs as procedures wasn’t mind-boggling enough, consider that, in a language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing `0` and the operation of adding `1` as

```scheme
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
```

This representation is known as Church numerals, after its inventor, Alonzo Church, the logician who invented the λ-calculus.

Define one and two directly (not in terms of `zero` and `add-1`). (Hint: Use substitution to evaluate `(add-1 zero)`). Give a direct definition of the addition procedure `+` (not in terms of repeated application of `add-1`).

# Answer

One:

  ```scheme
  (lambda (f) (lambda (x) (f ((zero f) x)))
  ```

  Because we're using call-by-value redex reduction, this is the simplest form that we get. However, because `zero` always terminate and does not have any side effect whatsoever, one can prove that this is equivalent to:

  ```scheme
  (lambda (f) (lambda (x) (f ((zero f) x)))
  (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
  (lambda (f) (lambda (x) (f x)))
  ```

One can guess that `n` is represented by the application of `f` `n` times to `x`:

  ```scheme
  (lambda (f) (lambda (x) (f (f ... (f x)))))
  ```

Two:

  ```scheme
  (lambda (f) (lambda (x) (f (f x))))
  ```

Direct definition of `+`:

  ```scheme
  (define (+ n m)
    (lambda (f) (lambda (x) ((n f) ((m f) x)))))
  ```
