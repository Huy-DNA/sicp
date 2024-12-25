## Question

Define a better version of `make-rat` that handles both positive and negative arguments. `make-rat` should normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, and if the rational number is negative, only the numerator is negative.

## Answer

The improved `make-rat`:

```
(define (make-rat numer denom)
  (cond ((and (<= numer 0) (< denom 0)) (make-rat (- numer) (- denom)))
        ((and (>= numer 0) (> denom 0)) (let ((g (gcd n d)))
                                             (cons (/ n g) (/ d g)))
        (make-rat (- (abs numer)) (abs denom))))
```

