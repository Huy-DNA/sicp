# Problem

Simpson’s Rule is a more accurate method of numerical integration than the method illustrated above. Using Simpson’s Rule, the integral of a function `f` between `a` and `b` is approximated as:

$$\frac{h}{3} (y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 + ... + 2y_{n-2} + 4y_{n-1} + y_n)$$

where $h = (b - a)/n$, for some even integer `n`, and $yk = f(a + kh)$. (Increasing `n` increases the accuracy of the approximation.) Define a procedure that takes as arguments `f`, `a`, `b`, and `n` and returns the value of the integral, computed using Simpson’s Rule. Use your procedure to integrate `cube` between `0` and `1` (with `n = 100` and `n = 1000`), and compare the results to those of the integral procedure shown above.

# Answer

New integral:

```scheme
(define (integral f a b n)
  (define step-size (/ (- b a) (* n 1.0)))
  (define (next-coefficient k)
    (cond ((= k 4) 2)
          ((= k 2) 4)))
  (define (integral-iter c k)
    (if (>= c b)
      0
      (+ (* k (f c))
         (integral-iter (+ c step-size) (next-coefficient k)))))
  (* (/ step-size 3.0)
     (+ (f a)
        (integral-iter (+ a step-size) 4)
        (f b))))
```

Testing with `cube`:

```scheme
(define (cube x)
  (* x x x))
```

Results:

- `n = 100`: 

  - Simpson:
  
    ```
    > (integral cube 0 1 100)
    0.2500000000000002
    ```
  - Textbook version:

    ```
    > (integral cube 0 1 0.01)
    0.24502500000000038
    ```

- `n = 1000`:

  - Simpson:

    ```
    > (integral cube 0 1 1000)
    0.2500000000000009
    ```

  - Textbook version:

    ```
    > (integral-a cube 0 1 0.001)
    0.24950025000000076
    ```

-> The Simpson version converges faster
