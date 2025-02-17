# Problem
Implement the `lookup` procedure for the case where the set of records is structured as a binary tree, ordered by the numerical values of the keys.

# Answer

```scheme
(define (lookup given-key db)
  (cond ((null? db) false)
    ((= given-key (key (entry db))) (entry db))
    ((< given-key (key (entry db)))
      (lookup given-key (left-branch db)))
    ((> given-key (key (entry db)))
      (lookup given-key (right-branch db)))))
```
