# Problem

The exponentiation algorithms in this section are based on performing exponentiation by means of repeated multiplication. In a similar way, one can perform integer multiplication by means of repeated addition. The following multiplication procedure (in which it is assumed that our language can only add, not multiply) is analogous to the `expt` procedure:

```scheme
(define (* a b)
  (if (= b 0)
    0
    (+ a (* a (- b 1)))))
```
This algorithm takes a number of steps that is linear in `b`. Now suppose we include, together with addition, operations `double`, which doubles an integer, and `halve`, which divides an (even) integer by 2. Using these, design a multiplication procedure analogous to `fast-expt` that uses a logarithmic number of steps.

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

Idea:

  - $$a * b = a * (b / 2) * 2 if b is even$$

  - $$a * b = a + a * ((b - 1) / 2) * 2 if b is odd$$

A direct translation yields a logarithmic recursive process.

See `main.rkt`.
