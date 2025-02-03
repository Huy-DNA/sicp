# Problem

Here are two possible constructors for frames:

```scheme
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
```

For each constructor supply the appropriate selectors to produce an implementation for frames.

# Answer

In Racket, first version:

```scheme
(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (car (cdr f))
(define (edge2-frame f)
  (car (cdr (cdr f))))
```

In Racket, second version:

```scheme
(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (car (cdr f))
(define (edge2-frame f)
  (cdr (cdr f)))
```
