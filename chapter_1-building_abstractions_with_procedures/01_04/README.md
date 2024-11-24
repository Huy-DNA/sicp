## Problem

Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

```scheme
(define (a-plus-abs-b a b)
((if (> b 0) + -) a b))
```

## Answer

Suppose that we call `(a-plus-abs-b a b)`.

Here are the steps to evaluate this expression:

1. Evaluate the operator `a-plus-abs-b`, this is the compound procedure above.
2. Evaluate `a` and `b`.
3. Subtitute `a` and `b` into the body of `a-plus-abs-b`: `((if (> b 0) + -) a b)`.
4. Evaluate the operator expression `(if (> b 0) + -)`.
   - If the `b > 0`, `+` will be the result of the operator.
   - Else, `-` will be the result of the operator.
5. Evaluate `a` and `b`.
6. Evaluate either `(+ a b)` or `(- a b)`, based on the result of step 4.
