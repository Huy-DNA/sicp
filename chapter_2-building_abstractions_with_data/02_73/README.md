# Problem

Section 2.3.2 described a program that performs symbolic differentiation:
```scheme
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
           (if (same-variable? exp var) 1 0))
        ((sum? exp)
           (make-sum (deriv (addend exp) var)
                     (deriv (augend exp) var)))
        ((product? exp)
           (make-sum (make-product
                       (multiplier exp)
                       (deriv (multiplicand exp) var))
                     (make-product
                       (deriv (multiplier exp) var)
                       (multiplicand exp))))
        ⟨more rules can be added here⟩
        (else (error "unknown expression type: DERIV" exp))))
```
We can regard this program as performing a dispatch on the type of the expression to be differentiated. In this situation the “type tag” of the datum is the algebraic operator symbol (such as `+`) and the operation being performed is `deriv`. We can transform this program into data-directed style by rewriting the basic derivative procedure as
```scheme
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
                 (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
```
a. Explain what was done above. Why can’t we assimilate the predicates `number?` and `variable?` into the data-directed dispatch?
b. Write the procedures for derivatives of sums and products, and the auxiliary code required to install them in the table used by the program above.
c. Choose any additional differentiation rule that you like, such as the one for `exponents` (Exercise 2.56), and install it in this data-directed system.
d. In this simple algebraic manipulator the type of an expression is the algebraic operator that binds it together. Suppose, however, we indexed the procedures
in the opposite way, so that the dispatch line in `deriv` looked like
```scheme
((get (operator exp) 'deriv) (operands exp) var)
```
What corresponding changes to the derivative system are required?

# Answer

a. What was done:
   1. Check if `exp` is a plain number, if so, return `0`.
   2. Check if `exp` is a variable (which is underneath a symbol), if so, either return `0` or `1`.
   3. Lookup the type-and-operator table using the index `'deriv` and `(operator exp)` to get the corresponding derivation procedure, then apply it to `(operands exp)`, which strips the tag and the variable `var`.

   We can't assimilate the predicates `number?` and `variable?` into the data-directed dispatch because numbers and variables don't have type tags.
b. Installation of the derivative procedures of sums and products:
   ```scheme
   (define (install-derivative)
     (define (deriv-sum sum)
       (make-sum (deriv (car sum))
                 (deriv (cdr sum))))
     (define (deriv-product prod)
       (make-sum (make-product (deriv (car prod)) (cdr prod))
                 (make-product (deriv (cdr prod)) (car prod))))
     (put '+ 'deriv deriv-sum)
     (put '* 'deriv deriv-product))
   ```
c. Additional differentiation rule for exponent:
   ```scheme
   (define (deriv-exp exp)
      (make-product (exponent exp)
                    (make-exponent (base exp) (- (exponent exp) 1))))
   (put '^ 'deriv deriv-exp)
   ```
d. The corresponding changes:
   - Every `put` should be made in reverse: `(put 'deriv '+ deriv-sum)`.
