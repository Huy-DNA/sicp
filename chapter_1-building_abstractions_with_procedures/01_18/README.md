# Problem

Using the results of Exercise 1.16 and Exercise 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.

# Answer

We'll first define the given operations:

```scheme
(define (add a b)
  (+ a b))

(define (double x)
  (* x 2))

(define (halve x)
  (if (= (remainder x 2) 0)
    (/ x 2)
    (/ (- x 1) 2)))
```

Idea: We'll think of an invariant.
  
  - We'll define an iterative-process-yielding procedure `mul-iter s a b` with the invariant that `s + a * b = result`.

  - When `n = 0` we have `s = result`.

  - Each iteration will make `n` reach closer to `1`, the process will eventually terminate with `s` being the result.

See `main.rkt`.
