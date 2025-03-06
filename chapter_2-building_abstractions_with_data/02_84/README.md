# Problem
Using the `raise` operation of Exercise 2.83, modify the `apply-generic` procedure so that it coerces its arguments to have the same type by the method of successive raising, as discussed in this section. You will need to devise a way to test which of two types is higher in the tower. Do this in a manner that is “compatible” with the rest of the system and will not lead to problems in adding new levels to the tower.

# Answer

```scheme

(define (type-dist x)
  (let ((raised-x (raise x)))
    (if (eq (type-tag raised-x) (type-tag x))
      0
      (+ 1 (type-dist raised-x)))))

(define (is-higher x y)
  (> (type-dist x) (type-dist y)))

(define (is-lower x y)
  (< (type-dist x) (type-dist y)))

(define (is-eq x y)
  (= (type-dist x) (type-dist y)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args))
        (content (map contents args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc content)
        (if (= (length args) 2)
          (let ((first (car args))
                (second (cadr args)))
            (cond ((is-eq first second) (error "Unknown method"))
                  ((is-higher first second) (apply-generic op first (raise second))
                  (else (apply-generic op (raise first) second))))))))))
```
