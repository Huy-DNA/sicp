# Problem
Use the results of Exercise 2.63 and Exercise 2.64 to give `Θ(n)` implementations of `union-set` and `intersection-set` for sets implemented as (balanced) binary trees.

# Answer

Idea: Serialize the two trees into ordered lists in `Θ(n)` using `tree->list2`, using the two pointer technique to merge (union/intersect) the two list in `Θ(n)`, and build back the tree in `Θ(n)` using `list->tree`.

The merging procedure are shown below:

```scheme
(define (union-list l1 l2)
  (cond ((null? l1) l2)
        ((null? l2) l1)
        ((< (car l1) (car l2)) (cons (car l1) (union-list (cdr l1) l2)))
        ((< (car l2) (car l1)) (cons (car l2) (union-list (cdr l2) l1)))
        (else (cons (car l2) (union-list (cdr l2) (cdr l1)))))))

(define (intersect-list l1 l2)
  (cond ((null? l1) nil)
        ((null? l2) nil)
        ((< (car l1) (car l2)) (intersect-list (cdr l1) l2))
        ((< (car l1) (car l2)) (intersect-list (cdr l2) l1))
        (else (cons (car l1) (intersect-list (cdr l1) (cdr l2))))))
```
