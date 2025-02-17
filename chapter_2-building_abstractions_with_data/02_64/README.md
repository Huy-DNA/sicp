# Problem

The following procedure `list->tree` converts an ordered list to a balanced binary tree. The helper procedure `partial-tree` takes as arguments an integer `n` and list of at least `n` elements and constructs a balanced tree containing the first `n` elements of the list. The result returned by `partial-tree` is a pair (formed with `cons`) whose `car` is the constructed tree and whose `cdr` is the list of elements not included in the tree.

```scheme
(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result
             (partial-tree elts left-size)))
        (let ((left-tree (car left-result))
              (non-left-elts (cdr left-result))
              (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-elts))
                (right-result
                 (partial-tree
                  (cdr non-left-elts)
                  right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts
                   (cdr right-result)))
              (cons (make-tree this-entry
                               left-tree
                               right-tree)
                    remaining-elts))))))))
```

a. Write a short paragraph explaining as clearly as you can how `partial-tree` works. Draw the tree produced by `list->tree` for the list `(1 3 5 7 9 11)`.
b. What is the order of growth in the number of steps required by `list->tree` to convert a list of `n` elements?

# Answer
a. How `partial-tree` works:
   1. Compute the size of the left subtree.
   2. Build the left subtree by recursively call `partial-tree` on the same lsit but with the size of the left subtree.
   3. Extract the left subtree and the remaining list after building the left subtree.
   4. Compute the size of the right subtree by subtracting the size of the left subtree and 1 (for the entry at root).
   5. Extract from the remaining list after building the left subtree an element to be the entry at root.
   5. Build the right subtree by recursively call `partial-tree` on the remaining list after building the left subtree minus the first root element with the size of the right subtree.
   6. Build the tree with the left subtree, the entry at root, the right subtree.
   7. Return the tree along with the remaining elements after building the tree (which should be `'()`).

For the list `(1 3 5 6 9 11)`, the resulting tree is:

```
         5
   1           9
      3    6      11

```
b. We can prove that the order of growth is Θ(n) by induction: For a list of `i` elements, with `i >= 1`, at most `c*i` steps are taken, for some constants `c`.

If we choose `c` sufficiently large:
- For `i = 1`, we can assume that at most `c` steps are taken.

- Suppose this is correct for all `i <= k`, for `i = k`:
  - The recursive call for the left subtree takes at most `c*floor((k-1)/2)` steps.
  - The recursive call for the right subtree takes at most `c*(k - floor((k-1)/2) - 1)` steps.
  - All other steps (`car`, `cdr`, `make-tree`, `let`, `if`, etc) take some fixed constant steps `d <= c`.
  - Total steps: `c*floor((k-1)/2) + c*(k - floor((k-1)/2) - 1) + d = c * (k - 1) + d <= c*k`.

  Therefore, this is correct for `i = k`.

The statement has been proven.
