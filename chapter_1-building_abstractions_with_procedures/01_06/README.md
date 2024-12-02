## Problem

Alyssa P. Hacker doesn’t see why `if` needs to be provided as a special form. “Why can’t I just define it as an ordinary procedure in terms of `cond`?” she asks. Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:

```scheme
  (define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
  (else else-clause)))
```

Eva demonstrates the program for Alyssa:

```scheme
  (new-if (= 2 3) 0 5)
  5
  (new-if (= 1 1) 0 5)
  0
```

Delighted, Alyssa uses `new-if` to rewrite the square-root program:

```scheme
  (define (sqrt-iter guess x)
    (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
```

What happens when Alyssa attempts to use this to compute square roots? Explain.

## Answer

Alyssa would run into an infinite recursion.

- The `if` special form is short-circuited, which means that the predicate is evaluated before the branches and a branch is only evaluated if it's needed.

- The procedure version `new-if` should be evaluated in applicative order on most Scheme implementation. This means that the branches are eagerly evaluated before passing into the procedure. The consequence is that `sqrt-iter` always calls `sqrt-iter`.
