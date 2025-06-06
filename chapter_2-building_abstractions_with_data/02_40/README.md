# Problem

Define a procedure `unique-pairs` that, given an integer `n`, generates the sequence of pairs `(i, j)` with `1 <= j < i <= n`. Use `unique-pairs` to simplify the definition of `prime-sum-pairs` given above.

# Answer

```scheme
(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (generate-interval 1 (- i 1))))
           (generate-interval 1 n)))
```
