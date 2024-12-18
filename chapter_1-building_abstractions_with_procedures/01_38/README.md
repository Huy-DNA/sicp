# Problem

In 1737, the Swiss mathematician Leonhard Euler published a memoir De Fractionibus Continuis, which included a continued fraction expansion for `e - 2`, where `e` is the base of the natural logarithms. In this fraction, the $N_i$ are all `1`, and the $D_i$ are successively `1`, `2`, `1`, `1`, `4`, `1`, `1`, `6`, `1`, `1`, `8`, . . .. Write a program that uses your cont-frac procedure from Exercise 1.37 to approximate `e`, based on Euler’s expansion.

# Answer

The numerator:
    ```scheme
    (lambda (x) 1.0)
    ```

The denominator:
    ```scheme
    (define (d i)
      (define r (remainder i 11))
      (cond ((= r 0) 8.0)
            ((= r 1) 1.0)
            ((= r 2) 2.0)
            ((= r 3) 1.0)
            ((= r 4) 1.0)
            ((= r 5) 4.0)
            ((= r 6) 1.0)
            ((= r 7) 1.0)
            ((= r 8) 6.0)
            ((= r 9) 1.0)
            (else 1.0)))
    ```

Estimate `e`:
    ```scheme
    (+ 2.0
       (cont-frac (lambda (x) 1.0)
                  d
                  1000))
    ```
