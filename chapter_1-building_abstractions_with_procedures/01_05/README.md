## Problem

Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

```scheme
(define (p) (p))
(define (test x y)
(if (= x 0) 0 y))
```

Then he evaluates the expression

```scheme
(test 0 (p))
```

What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form if is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.)

## Answer

Note that the `if` special form possesses short-circuiting behavior.

With applicative-order evaluation, we evaluate all arguments before passing them to the procedure.

1. `(test 0 (p))`
2. Evaluate the operator `test` which is the procedure defined above.
3. Evaluate `0`.
4. Evaluate `(p)`, which evaluates to `(p)`, which recurses indefinitely.

With normal-order evaluate, we substitute the arguments into the procedure body first.

1. `(test 0 (p))`
2. Evaluate the operator `test` which is the procedure defined above.
3. Substitute `0` and `(p)` into the body of `test`.
4. `(if (= 0 0) 0 (p)))` which returns `0`.

Therefore, Ben can tell that:

- The interpreter uses applicative-order evaluation if the given expression loops indefinitely.
- The interpreter uses normal-order evaluation if the given expression returns `0`.
