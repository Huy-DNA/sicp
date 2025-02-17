# Problem
Each of the following two procedures converts a binary tree to a list.

```scheme
(define (tree->list-1 tree)
  (if (null? tree)
    '()
    (append (tree->list-1 (left-branch tree))
            (cons (entry tree)
                  (tree->list-1
                    (right-branch tree))))))
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                              (right-branch tree)
                              result-list)))))
  (copy-to-list tree '()))
```
a. Do the two procedures produce the same result for every tree? If not, how do the results differ? What lists do the two procedures produce for the trees in Figure 2.16?
b. Do the two procedures have the same order of growth in the number of steps required to convert a balanced tree with `n` elements to a list? If not, which one grows more slowly?

# Answer

a. The two procedures produce the same result for every tree.
b. No, the `tree->list-2` grows more slowly. With `n` nodes, `tree->list-2`'s order of growth is Θ(n), while `tree->list-1`, for a degenerated tree to a left-skewd list, produces Θ(n^2) due to `append` having to iterate the left sublist repeatedly.
