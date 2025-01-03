# Problem

We saw in Section 1.3.3 that attempting to compute square roots by naively finding a fixed point of `y -> x/y` does not converge, and that this can be fixed by average damping. The same method works for finding cube roots as fixed points of the average-damped `y -> x/y^2`. Unfortunately, the process does not work for fourth roots—a single average damp is not enough to make a fixed-point search for `y -> x/y^3` converge. On the other hand, if we average damp twice (i.e., use the average damp of the average damp of `y -> x/y^3)` the fixed-point search does converge. Do some experiments to determine how many average damps are required to compute nth roots as a fixed-point search based upon repeated average damping of `y -> x/y^(n-1)`. Use this to implement a simple procedure for computing nth roots using `fixed-point`, `average-damp`, and the repeated procedure of Exercise 1.43. Assume that any arithmetic operations you need are available as primitives.

# Answer

In short, the nth-root of `x` is the fixed point of `x/y^(n-1)` using average damping repeated `n` times.

```scheme
(define (nth-root x n)
  (define (original-f y) (/ x
                            ((repeated (lambda (t) (* y t))
                                       (- n 1)) 1)))
  (fixed-point ((repeated average-damp n) original-f)
               1))
```
