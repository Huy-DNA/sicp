# Problem

`right-split` and `up-split` can be expressed as instances of a general splitting operation. Define a procedure `split` with the property that evaluating

```scheme
(define right-split (split beside below))
(define up-split (split below beside))
```

produces procedures `right-split` and `up-split` with the same behaviors as the ones already defined.

# Answer

```scheme
(define (split o1 o2)
  (define (split-rec painter n)
    (if (= n 0)
      painter
      (let ((smaller-painter) (split-rec painter (- n 1)))
        (o1 painter
           (o2 smaller-painter smaller-painter)))))
  (lambda (painter n)
    (split-rec painter n)))
```
