# Problem

The process that a procedure generates is of course dependent on the rules used by the interpreter. As an example, consider the iterative `gcd` procedure given above. Suppose we were to interpret this procedure using normal-order evaluation, as discussed in Section 1.1.5. (The normal-order-evaluation rule for `if` is described in Exercise 1.5.) Using the substitution method (for normal order), illustrate the process generated in evaluating `(gcd 206 40)` and indicate the remainder operations that are actually performed. How many remainder operations are actually performed in the normal-order evaluation of `(gcd 206 40)`? In the applicative-order evaluation?

# Answer

The procedure:

```scheme
(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))
```

In the applicative-order evaluation:

```scheme
(gcd 206 40)
(gcd 40 6) ; remainder count: 1
(gcd 6 4)  ; remainder count: 2
(gcd 4 2)  ; remainder count: 3
(gcd 2 0)  ; remainder count: 4
2
```

In the normal-order evaluation:

```scheme
(gcd 206 40)
(gcd 40 (remainder 206 40))
(if (= (remainder 206 40) 0)
  40
  (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))     ; remainder count: 1
(if (= (remainder 40 (remainder 206 40)) 0)
  (remainder 206 40)
  (gcd (remainder 40 (remainder 206 40))
       (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
(gcd (remainder 40 (remainder 206 40))
     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))     ; remainder count: 3
(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
  (remainder 40 (remainder 206 40))
  (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
       (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))    ; remainder count: 7
(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
  ...)
(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))   ; remainder count: 14
2   ; remainder count: 18 
```

This yields a non-linear recursive process because of the deferred evaluation has to be kept track of.
