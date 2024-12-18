# Problem

a. An infinite continued fraction is an expression of the form:

$$
\displaystyle f = \frac{N_1}{D_1 + \frac{N_2}{D_2 + \frac{N_3}{D_3 + \cdots}}}
$$

As an example, one can show that the infinite continued fraction expansion with the $N_i$ and the $D_i$ all equal to `1` produces `1/ϕ`, where ϕ is the golden ratio (described in Section 1.2.2). One way to approximate an infinite continued fraction is to truncate the expansion after a given number of terms. Such a truncation—a so-called **k-term finite continued fraction**—has the form

$$
\displaystyle f = \frac{N_1}{D_1 + \frac{N_2}{\ddots + \frac{N_k}{D_k}}}
$$

Suppose that `n` and `d` are procedures of one argument (the term index `i`) that return the $N_i$ and $D_i$ of the terms of the continued fraction. Define a procedure `cont-frac` such that evaluating `(cont-frac n d k)` computes the value of the **k-term finite continued fraction**. Check your procedure by approximating `1/ϕ` using

```scheme
(cont-frac (lambda (i) 1.0)
  (lambda (i) 1.0)
  k)
```

for successive values of `k`. How large must you make `k` in order to get an approximation that is accurate to 4 decimal places?

b. If your `cont-frac` procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

# Answer

Minimum `k` to get an approximation that is accurate to 4 decimal places: `11`.
  ```scheme
  > (cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 11)
  0.6180555555555556
  ```

Recursive version: [link](/chapter_1-building_abstractions_with_procedures/01_37/recursive.rkt)

Iterative version: [link](/chapter_1-building_abstractions_with_procedures/01_37/iterative.rkt)
