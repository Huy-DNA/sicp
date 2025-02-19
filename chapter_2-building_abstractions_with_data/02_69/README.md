# Problem

The following procedure takes as its argument a list of symbol-frequency pairs (where no symbol appears in more than one pair) and generates a Huffman encoding tree according to the Huffman algorithm.

```scheme
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
```

`make-leaf-set` is the procedure given above that transforms the list of pairs into an ordered set of leaves. `successive-merge` is the procedure you must write, using `make-code-tree` to successively merge the smallest-weight elements of the set until there is only one element left, which is the desired Huffman tree. (This procedure is slightly tricky, but not really complicated. If you find yourself designing a complex procedure, then you are almost certainly doing something wrong. You can take significant advantage of the fact that we are using an ordered set representation.)

# Answer

This one doesn't really work if `leaf-set` contains only one leaf - using the resulting Huffman encoding tree, we don't really know whether to use `0` or `1` to encode the only symbol.

```scheme
(define (successive-merge leaf-set)
  (cond ((null? leaf-set) (error "Leaf set must not be empty"))
        ((null? (cdr leaf-set)) leaf-set)
        (else (successive-merge (adjoin-set (make-code-tree (car leaf-set)
                                                            (cadr leaf-set))
                                            (cdr (cdr leaf-set)))))))
```
