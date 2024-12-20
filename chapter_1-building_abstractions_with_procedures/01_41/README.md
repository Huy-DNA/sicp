# Problem

Define a procedure `double` that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice. For example, if `inc` is a procedure that adds 1 to its argument, then `(double inc)` should be a procedure that adds 2. What value is returned by

```scheme
(((double (double double)) inc) 5)
```

# Answer

See `main.rkt`.

The result should be 21. The reason:

- `(double double)` returns a function `f` such that `(f x)` is equivalent to `(double (double x))`.

- `(double f)` returns a function `g` such that `(g x)` is equivalent to `(f (f x))`.

- Therefore, `(g inc)` is equivalent to `(f (f inc))` -> `(f (double (double inc)))` -> `(f (double inc-2))` -> `(f inc-4)` -> `(double (double inc-4))` -> `(double inc-8)` -> `inc-16`.
