# Problem

Using reasoning analogous to Alyssa’s, describe how the difference of two intervals may be computed. Define a corresponding subtraction procedure, called `sub-interval`.

# Answer

The difference of interval `i1` and `i2` is an interval whose:

- Lower bound is the upper bound of `i1` minus the lower bound of `i2`.
- Upper bound is the lower bound of `i1` minus the upper bound of `i2`.

See `main.rkt`.
