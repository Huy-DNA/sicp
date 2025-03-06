# Problem
Suppose you are designing a generic arithmetic system for dealing with the tower of types shown in Figure 2.25: integer, rational, real, complex. For each type (except complex), design a procedure that raises objects of that type one level in the tower. Show how to install a generic `raise` operation that will work for each type (except complex).

# Answer

```scheme
(define (install-integer-package)
  (define (raise n) (make-rat n 1))
  (put-raise 'integer
             integer->complex))

(define (install-rational-package)
  (define (raise r) (/ (* 1.0 (numerator r)) (denominator r)))
  (put-raise 'rational
             rational->real))

(define (install-real-package)
  (define (raise n) (make-complex-from-real-imag n 0))
  (put-raise 'real
             real->complex))

(define (raise n)
  (let ((type (type-tag n))
        (content (contents n)))
    (let ((raise-proc (get-raise type)))
       (if raise-proc
          (raise-proc content)
          n))))
```
