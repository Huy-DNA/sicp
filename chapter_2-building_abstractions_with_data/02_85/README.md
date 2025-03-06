# Problem
This section mentioned a method for “simplifying” a data object by lowering it in the tower of types as far as possible. Design a procedure `drop` that accomplishes this for the tower described in Exercise 2.83. The key is to decide, in some general way, whether an object can be lowered. For example, the complex number `1.5 + 0i` can be lowered as far as real, the complex number `1 + 0i` can be lowered as far as integer, and the complex number `3i` cannot be lowered at all. Here is a plan for determining whether an object can be lowered: Begin by defining a generic operation project that “pushes” an object down in the tower. For example, projecting a complex number would involve throwing away the imaginary part. Then a number can be dropped if, when we project it and raise the result back to the type we started with, we end up with something equal to what we started with. Show how to implement this idea in detail, by writing a `drop` procedure that drops an object as far as possible. You will need to design the various projection operations and install `project` as a generic operation in the system. You will also need to make use of a generic equality predicate, such as described in Exercise 2.79. Finally, use drop to rewrite `apply-generic` from Exercise 2.84 so that it “simplifies” its answers.

# Answer

```scheme
(define (install-rational-package)
  (define (try-drop r)
    (if (eq? (denominator r) 1))
      (numerator r)
      false)
  (put-drop 'rational
            try-drop))

(define (install-real-package)
  (define (try-drop r)
    (if ...)
      ...
      false)
  (put-drop 'real
            try-drop))

(define (install-complex-package)
  (define (try-drop r)
    (if (eq? (imag-part r) 0))
      (real-part r)
      false)
  (put-drop 'complex
            try-drop))

(define (drop n)
  (let ((val (try-drop n))
    (if val
      (drop val)
      n))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args))
        (content (map contents args)))
    (let ((proc (get op type-tags)))
      (if proc
        (drop (apply proc content))
        (if (= (length args) 2)
          (let ((first (car args))
                (second (cadr args)))
            (cond ((is-eq first second) (error "Unknown method"))
                  ((is-higher first second) (apply-generic op first (raise second))
                  (else (apply-generic op (raise first) second))))))))))
```
