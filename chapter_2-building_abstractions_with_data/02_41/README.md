# Problem

Write a procedure to find all ordered triples of distinct positive integers `i`, `j`, and `k` less than or equal to a given integer `n` that sum to a given integer `s`.

# Answer

```scheme
(define (triples n)
  (flatmap
    (lambda (i)
      (flatmap
        (lambda (j)
          (map (lambda (k) (list i j k))
               (generate-interval 1 n))
        (generate-interval 1 n)))
    (generate-interval 1 n)))
```
