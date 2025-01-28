# Problem

You can obtain an even more general version of `accumulate` (Exercise 1.32) by introducing the notion of a `filter` on the terms to be combined. That is, combine only those terms derived from values in the range that satisfy a specified condition. The resulting `filtered-accumulate` abstraction takes the same arguments as `accumulate`, together with an additional predicate of one argument that specifies the filter.

Write `filtered-accumulate` as a procedure. Show how to express the following using filtered-accumulate:
a. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a `prime?` predicate already written).
b. the product of all the positive integers less than n that are relatively prime to n (i.e., all positive integers i < n such that GCD(i, n) = 1).

# Answer

```scheme
(define (filtered-accumulate combiner null-value filter term a next b)
  (define (accumulate-iter c)
    (define term-c (term c))
    (cond ((> c b) null-value)
          ((not (filter term-c)) (accumulate-iter (next c)))
          (else (combiner (term c)
                          (accumulate-iter (next c))))))
  (accumulate-iter a))
```

a. Sum of the squares of the prime numbers in the interval a to b:

   ```scheme
   (filtered-accumulate + 0 prime? square a inc b)
   ```

b. Product of all positive integers less than n that are relatively prime to n:

   ```scheme
   (filtered-accumulate * 1 co-prime-with-n square 1 inc n)
   ```

# Remarks

- The abstraction get generalized & more powerful each time.

- However, the biggest drawback is that its interface consistently gets more bloated. Assume that a programmer just want to accumulate with no filter, they would have to pass a predicate that will always return `true`, which increases the boilerplate code.

- Another implication is that because the abstraction interfaces become more complex, it increases the cognitive load for the programmer to use it. -> Less flexibility.

How do they solve this problem later in this book?

- Introduce the `list` data structure as the common interface for `accumulate` and `filter` to act on.

Conclusion: The takeaway point is that we should focus on creating abstractions that "compose" well, which usually implies simplicity, flexibility & comprehensibility. The `list` solution is a demonstration of this.
# Related exercises

- [1.31](../01_31/README.md)
- [1.32](../01_32/README.md)
