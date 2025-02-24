# Problem
Implement the constructor `make-from-mag-ang` in message-passing style. This procedure should be analogous to the `make-from-real-imag` procedure given above.

# Answer

```scheme
(define (make-from-mag-ang magnitude angle)
  (define (dispatch op)
    (cond ((= op 'real-part) (* magnitude (cos angle)))
          ((= op 'imag-part) (* magnitude (sin angle)))
          ((= op 'magnitude) magnitude)
          ((= op 'angle) angle)
          (else (error "Unknown op" op))))
  dispatch)
```
