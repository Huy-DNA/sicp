# Problem

Complete the following definitions of `reverse` (Exercise 2.18) in terms of `fold-right` and `fold-left` from Exercise 2.38:

```scheme
(define (reverse sequence)
  (fold-right (lambda (x y) <??>) nil sequence))
(define (reverse sequence)
  (fold-left (lambda (x y) <??>) nil sequence))
```

# Answer

```scheme
(define (reverse sequence)
  (fold-right (lambda (x y) (cons x y)) nil sequence))
(define (reverse sequence)
  (fold-left (lambda (x y) (append x y)) nil sequence))
```
