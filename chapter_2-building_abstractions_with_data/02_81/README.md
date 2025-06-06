# Problem

Louis Reasoner has noticed that `apply-generic` may try to coerce the arguments to each other’s type even if they already have the same type. Therefore, he reasons, we need to put procedures in the coercion table to coerce arguments of each type to their own type. For example, in addition to the `scheme-number->complex` coercion shown above, he would do:

```scheme
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-coercion 'scheme-number
              'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)
```

a. With Louis’s coercion procedures installed, what happens if `apply-generic` is called with two arguments of type scheme-number or two arguments of type complex for an operation that is not found in the table for those types? For example, assume that we’ve defined a generic exponentiation operation:

```scheme
(define (exp x y) (apply-generic 'exp x y))
```

and have put a procedure for exponentiation in the Scheme-number package but not in any other package:

```scheme
;; following added to Scheme-number package
(put 'exp '(scheme-number scheme-number)
(lambda (x y) (tag (expt x y))))
; using primitive expt
```

What happens if we call `exp` with two complex numbers as arguments?

b. Is Louis correct that something had to be done about coercion with arguments of the same type, or does `apply-generic` work correctly as is?

c. Modify `apply-generic` so that it doesn’t try coercion if the two arguments have the same type. 

# Answer

a. If `apply-generic` is called with two arguments of type scheme-number or two arguments of type complex for an operation is not found for those types, infinite recursion occur:
  - `apply-generic` fails to find the operation.
  - `apply-generic` finds out the self-coercion procedures.
  - `apply-generic` coerce the first arg.
  - `apply-generic` recalls itself with the same two args.

b. `apply-generic` works correctly as is, it will error when an operation is not found those types.

c.

```scheme
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map content args))
        (if (= (length args) 2)
          (if (eq? (car type-tags) (cadr type-tags))
            (error "No method for these types")
            (let ((type0->type1 (get-coercion (car type-tags) (cadr type-tags)))
                  (type1->type0 (get-coercion (cadr type-tags) (car type-tags))))
              (cond (type0->type1
                      (apply-generic op (type0->type1 (car args)) (cadr args)))
                    (type1->type0
                      (apply-generic op (car args) (type1->type0 (cadr args))))
                    (else (error "No method for these types"))))))))))
```
