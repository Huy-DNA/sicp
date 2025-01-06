# Problem

Redefine `count-leaves` from Section 2.2.2 as an accumulation:

```scheme
(define (count-leaves t)
  (accumulate <??> <??> (map <??> <??>)))
```

# Answer

```scheme
(define (count-leaves t)
  (accumulate + 0 (map (lambda (sub-tree)
                         (if (pair? sub-tree)
                           (count-leaves sub-tree)
                           sub-trees)))))
```
