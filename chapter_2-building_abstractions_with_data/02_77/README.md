# Problem

Louis Reasoner tries to evaluate the expression `(magnitude z)` where `z` is the object shown in Figure 2.24. To his surprise, instead of the answer `5` he gets an error message from `apply-generic`, saying there is no method for the operation `magnitude` on the types `(complex)`. He shows this interaction to Alyssa P. Hacker, who says “The problem is that the complex-number selectors were never defined for complex numbers, just for polar and rectangular numbers. All you have to do to make this work is add the following to the complex package:”
```scheme
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)
```
Describe in detail why this works. As an example, trace through all the procedures called in evaluating the expression `(magnitude z)` where `z` is the object shown in Figure 2.24. In particular, how many times is `apply-generic` invoked? What procedure is dispatched to in each case?

# Answer

This works because `(magnitude z)` invokes `(apply-generic 'magnitude z)` which in turn invokes `((get 'magnitude (type-tag z)) (contents z))`.

Example from Figure 2.24:
  1. `(magnitude z)` is triggered.
  2. `apply-generic` is invoked, it dispatches on `z`'s type, which is `complex` -> `(magnitude (contents z))` from complex package is invoked.
  3. `apply-generic` is invoked, it dispatched on `(contents z)`'s type, which is `rectangular` -> `magnitude-rectangular` is invoked.
