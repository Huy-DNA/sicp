# Problem

Fill in the missing expression to complete the following definitions of some basic list-manipulation operations as accumulations:

```scheme
(define (map p sequence)
  (accumulate (lambda x y) <??>) nil sequence))
(define (append seq1 seq2)
  (accumulate cons <??> <??>))
(define (length sequence)
  (accumulate <??> 0 sequence))
```

# Answer

This assumes that `accumulate` is like fold-right.

```scheme
(define (map p sequence)
  (accumulate ((lambda x y) (cons (p b) y)) nil sequence))
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(define (length sequence)
  (accumulate + 0 sequence))
```
