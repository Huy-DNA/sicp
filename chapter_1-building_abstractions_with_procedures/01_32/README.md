# Problem

a. Show that `sum` and `product` (Exercise 1.31) are both special cases of a still more general notion called `accumulate` that combines a collection of terms, using some general accumulation function:

```scheme
(accumulate combiner null-value term a next b)
```

`accumulate` takes as arguments the same term and range specifications as `sum` and `product`, together with a `combiner` procedure (of two arguments) that specifies how the current term is to be combined with the accumulation of the preceding terms and a `null-value` that specifies what base value to use when the terms run out.

Write `accumulate` and show how `sum` and `product` can both be defined as simple calls to accumulate.

b. If your `accumulate` procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

# Answer

- Linear recursive version:

  ```scheme
  ; similar to fold-right
  (define (accumulate combiner null-value term a next b)
    (define (accumulate-iter c)
      (if (> c b)
        null-value
        (combiner (term c)
                  (accumulate-iter (next c)))))
    (accumulate-iter a))
  ```

- Linear iterative version:

  ```scheme
  ; similar to fold-left
  (define (accumulate combiner null-value term a next b)
    (define (accumulate-iter c result)
      (if (> c b)
        result
        (accumulate-iter (next c) (combiner result (term c)))))
    (accumulate-iter a null-value))
  ```

# Related exercises

- [1.31](../01_31/README.md)
- [1.33](../01_33/README.md)
