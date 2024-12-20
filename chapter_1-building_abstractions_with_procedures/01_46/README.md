# Problem

Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as **iterative improvement**. Iterative improvement says that, to compute something, we start with an initial guess for the answer, test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess. Write a procedure `iterative-improve` that takes two procedures as arguments: a method for telling whether a guess is good enough and a method for improving a guess. `iterative-improve` should return as its value a procedure that takes a guess as argument and keeps improving the guess until it is good enough. Rewrite the `sqrt` procedure of Section 1.1.7 and the `fixed-point` procedure of Section 1.3.3 in terms of `iterative-improve`.

# Answer

The `iterative-improve` procedure:

  ```scheme
  (define (iterative-improve good-enough? improve-guess)
     (define (iterative-improve-iter guess)
       (if (good-enough? guess)
         guess
         (iterative-improve-iter (improve-guess guess))))
     iterative-improve-iter)
  ```

Rewrite the `sqrt` procedure:

  ```scheme
  (define (sqrt x)
    (define (good-enough? guess)
      (< (abs (- (* guess guess) x)) 0.0001))
    (define (improve-guess guess)
      (average guess (/ x guess)))
    (iterative-improve good-enough? improve-guess))
  ```

Rewrite the `fixed-point` procedure:

  ```scheme
  (define (fixed-point f)
    (define (good-enough? guess)
      (< (abs (- (f guess) guess)) 0.0001))
    (define (improve-guess guess)
      (f guess))
    (iterative-improve good-enough? improve-guess))
  ```
